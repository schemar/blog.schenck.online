---
title: Glitch Resilient Future
slug: glitch-resilient-future
date_published: 2020-07-26T10:32:06.000Z
date_updated: 2020-07-26T10:32:06.000Z
tags:
- Images
- Manipulation
excerpt: In this post I write about the creation of posters on the topic "resilient future". For that, I created a glitching algorithm in processing.
---

I always wanted to write code that distorts images. I gave it a first shot with [processing](https://processing.org/).

The code applies three consecutive passes of distortion with differing strengths:

1. RGB noise moves the RGB values by different amounts
2. Pixel shift moves whole pixels up/down
3. Pixel scrumble moves whole pixels around

The strength of all three passes is `0` at the bottom of the image and increases to its max at the top of the image. The bottom also has a range where there is no distortion applied at all.

Due to the way the algorithm works, you can still clearly identify the kind of image from the bottom part. The most interesting part in my opinion is around the middle, while at the top it becomes unrecognizable for most inputs.

Below are two examples of what the outcome could look like. You can find the code that I wrote to generate these images on [GitHub](https://github.com/schemar/generative/tree/master/processing/glitch)[.](GitHub)

![](/images/giltch_1.jpg)

![](/images/glitch_glitch_1.jpg_run_5-1.png)

Photo by [H.F.E & CO](https://unsplash.com/@happyfaceemoji?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText) on [Unsplash](https://unsplash.com/?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText)

![](/images/glitch_2.jpg)

![](/images/glitch_glitch_2.jpg_run_1.png)

Photo by [Jeffrey Grospe](https://unsplash.com/@jgrospe?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText) on [Unsplash](https://unsplash.com/?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText)
I used the glitch algorithm to create a series of posters on the topic of "resilient future". The idea behind it is that while the image glitches more and more towards the top (the future), the “Stay Resilient” lettering represents the original unglitched image; therefore being “resilient”. The original images belong to [Futurice](https://futurice.com/).

![](/images/resilient_3.jpg)

![](/images/resilient_5.jpg)

![](/images/resilient_6.jpg)

![](/images/resilient_8.jpg)

Stay resilient with Futurice
