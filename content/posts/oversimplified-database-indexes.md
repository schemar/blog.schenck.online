---
title: Oversimplified Database Indexes
slug: oversimplified-database-indexes
date: 1970-01-01T00:00:00.000Z
author: Martin
lastmod: 2020-09-07T19:47:45.000Z
tags:
- Software
- Oversimplified
draft: true
---

> This article oversimplifies databases and database indexes. You can use it as a starting point when learning about database indexes or you can use it as a reference to come back to when you are still learning about databases and indexes. If you want to learn everything about databases, you need to gather more detailed resources like official documentation.
> In this article, we use [PostgreSQL](https://www.postgresql.org/) ([[Postgres](https://www.postgresql.org/docs/12/history.html)](https://www.enterprisedb.com/blog/postgres-vs-postgresql)) as an example. Different database implementations differ, but the basic concept of how indexes work is more or less similar.

## Storage

When you don't know anything about  databases and you do not think about it, you might assume some magical storage mechanism that databases use to store their data. In reality, however, it is very simple. For example, [Postgres](https://www.postgresql.org/) stores files on disk and uses [one file per table and index](https://www.postgresql.org/docs/12/storage-file-layout.html) (with exceptions).

Each of these files is split into [pages](https://www.postgresql.org/docs/12/storage-page-layout.html). The default size of a page is 8kB. Each page has a header with information on where its contained rows are located within the page. And the page contains, of course, the rows themselves.

This means that Postgres reads files from disk in order to access table data.

## Accessing Records

[Table 1](#table-1) shows example data that we want to use in this article for all further examples.
Table 1: Example table of vehiclesidhorse_powernumber_of_wheelsis_stick_shiftfuel_type...103754truegas1041204truediesel106904falseelectric...
Let us assume that the table contains many more rows than are depicted here, but let us focus on the listed rows in order to grasp some concepts with a limited data set that fits into our brain.

We can send [SQL](https://en.wikipedia.org/wiki/SQL) queries to Postgres to ask  for specific rows of the whole table. For example, we could ask for all vehicles that are stick shift, which would return the rows with the ids `103` and `104`. Or we could ask for all rows where the fuel type is gas, which would retunr the row with the id `103`. In real life, the statements that you use to get data are often more complex. However, these simple examples suffice to demonstrate the power of indexes.

How would Postgres now which vehicles are stick shift or which vehicles have the fuel type gas? It cannot know without looking at the data. So the straight-forward approach for Postgres is to do a [full table scan](https://en.wikipedia.org/wiki/Full_table_scan). This means that Postgres would read the whole table – all of its pages – in order to identify the matching rows. It keeps the matching rows as it passes them and returns all matching rows to the caller once the whole table has been read.

Now imagine a really, really big table with many rows. It could be many gigabytes in size. And now imagine looking for one specific row in that table. If you don't know where to look, you need to start reading the whole table until you find your entry. If you don't know that you are looking for specifically one vehicle, for example when you want to get all 2-wheel vehicles, you always have to read the whole table as you don't know if there will be more matching rows further down the table.

In addition to that, imagine that this needs to be done often. For example: every time a user opens a page of a vehicle on a website, you need to get that vehicle from the database and return it to the user's browser so that it can display its details. This would lead to a situation where you would need to ask Postgres often and Postgres would need to read the whole table every time you ask it. This can become a real bottleneck of your application, as loading a page might take many seconds depending on the size of the table. The bigger your table, the slower it gets.

## Indexes for Speed

You can utilize indexes to improve read-performance. Put simply, an index makes read queries faster by reading only a little bit of data first to find out where exactly the relevant rows are stored in the table file and then reading only those relevant rows from disk instead of the entire table.

### Value Indexes

Indexes use specific data structures to make searching for values fast. 

> It is a combination of all three.
> - Indexes store two numbers - page number and index of the row within that page. This is called tuple identified and there is a hidden column called `ctid` that you can read to see these identifiers (mentioned here [https://www.postgresql.org/docs/12/datatype-oid.html](https://www.postgresql.org/docs/12/datatype-oid.html))
> - Whole page containing the row is read from the disk and cached. The reason for this is that filesystems and operating systems work with blocks of data, so reading whole blocks not much slower than reading a part of it.
> - Page contains entry for each row that stores its offset and length (documented here [https://www.postgresql.org/docs/12/storage-page-layout.html](https://www.postgresql.org/docs/12/storage-page-layout.html)). The second part of the tuple identifier is used as an offset to this table.
> - I do not think any OS limitation apply here except that table data is split to 1GB files so that no filesystem limitations are hit.

- Store additional data to make query faster
- Show example tree for example table
- Explain how the tree increases speed by accessing the data on disk at specific points only instead of reading the whole file

### Range Indexes

In the section above we discussed how we can find rows where a column has a specific value. Another kind of index is one that makes it easy to find ranges of values. For example all vehicles that have 2, 3, or 4 wheels. But not more or less. A very common kind of index that [many](https://www.postgresql.org/docs/12/btree.html)[database](https://mariadb.com/kb/en/storage-engine-index-types/#b-tree-indexes)[systems](https://docs.oracle.com/cd/E11882_01/server.112/e40540/indexiot.htm#CNCPT1895)[support](https://docs.microsoft.com/en-us/sql/relational-databases/sql-server-index-design-guide?view=sql-server-ver15) for this use-case is a [B-tree index](https://git.postgresql.org/gitweb/?p=postgresql.git;a=blob;f=src/backend/access/nbtree/README;h=9692e4cdf64419e6f5ceb58b46bbeb192295d64a;hb=HEAD).

- See also [https://blog.rustprooflabs.com/2020/09/postgres-beta3-btree-dedup](https://blog.rustprooflabs.com/2020/09/postgres-beta3-btree-dedup)

### Full Text Indexes

- postgres GIN or elastic search...

What different kinds are there and what's their purpose

- index for finding specific values
- index for finding specific ranges
- others?

### Potential Drawbacks of Indexes

As always, there is a trade-off to be made. Indexes will make reading specific data from your tables faster, but they will make writing to the tables slower. On top of that, they need their own disk space to be stored. In order to have a useful index that reflects the current state of the table data, it needs to be updated every time that you update the table data. This means additional disk reads and writes when updating a table. Plus some extra CPU cycles to calculate the new index. Generally speaking, an index will help you with your database performance. But keep in mind that there are cases where they won't help or could even be counter-productive. A scenario where indexes could be harmful harmful is one where you often write many rows, but you rarely read them and maybe reading them is not even time-critical.

- Wrap up post

---

Cover photo by [benjamin lehman](https://unsplash.com/@benjaminlehman?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText) on [Unsplash](https://unsplash.com/s/photos/hdd?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText)
