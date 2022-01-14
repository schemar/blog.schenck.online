---
title: Generating Images
slug: generating-images
date: 2019-12-29T17:12:00.000Z
author: Martin
lastmod: 2020-01-03T18:09:36.000Z
tags:
- Generative
- Images
description: I looked into quil to generate images with clojure. I present some of the outcomes.
cover: /images/0005-b-1.png
---

Last year, around the same time, I looked into [quil](http://www.quil.info/) to generate images with [clojure](https://clojure.org/). You can find the code [on GitHub](https://github.com/schemar/generative). As you can see there, I have no experience with clojure and thus the code is not very readable.

Anyway, I generated some images with random components. The ones I like the most are the "Floating Triangles".

<figure>
  <div style="display: flex; flex-direction: row; justify-content: center;">
    <div style="flex: 1 1 0%;">
      {{< figure src="/images/0004.png" position="left" >}}
    </div>
    <div style="flex: 1 1 0%; margin-left: 0.75em;">
      {{< figure src="/images/0004-b.png" position="right" >}}
    </div>
    <div style="flex: 1 1 0%; margin-left: 0.75em;">
      {{< figure src="/images/0004-a.png" position="right" >}}
    </div>
  </div>
  <figcaption style="width: 100%; text-align: center; margin-top: -15px;">
    Floating Triangles
  </figcaption>
</figure>

For the "Breaking Triangles" it depends extremely on the colors, I think. I prefer two colors over three.

<figure>
  <div style="display: flex; flex-direction: row; justify-content: center;">
    <div style="flex: 1 1 0%;">
      {{< figure src="/images/0005-b.png" position="left" >}}
    </div>
    <div style="flex: 1 1 0%; margin-left: 0.75em;">
      {{< figure src="/images/0005-a.png" position="right" >}}
    </div>
    <div style="flex: 1 1 0%; margin-left: 0.75em;">
      {{< figure src="/images/0005.png" position="right" >}}
    </div>
  </div>
  <figcaption style="width: 100%; text-align: center; margin-top: -15px;">
    Breaking Triangles
  </figcaption>
</figure>

Below are the earliest attempts. I was first trying to figure out how clojure works and then how quil works.

<figure>
  <div style="display: flex; flex-direction: row; justify-content: center;">
    <div style="flex: 1 1 0%;">
      {{< figure src="/images/0003.png" position="left" >}}
    </div>
    <div style="flex: 1 1 0%; margin-left: 0.75em;">
      {{< figure src="/images/0003-a.png" position="right" >}}
    </div>
  </div>
  <figcaption style="width: 100%; text-align: center; margin-top: -15px;">
    Broken Circle
  </figcaption>
</figure>

A circle with differently (but similarly) colored segments was my first sketch.

<figure>
  <div style="display: flex; flex-direction: row; justify-content: center;">
    <div style="flex: 1 1 0%;">
      {{< figure src="/images/0002.png" position="left" >}}
    </div>
    <div style="flex: 1 1 0%; margin-left: 0.75em;">
      {{< figure src="/images/0002-a.png" position="right" >}}
    </div>
  </div>
  <figcaption style="width: 100%; text-align: center; margin-top: -15px;">
    Circle in Segments
  </figcaption>
</figure>
