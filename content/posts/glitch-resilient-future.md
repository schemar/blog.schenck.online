---
title: Glitch Resilient Future
slug: glitch-resilient-future
date: 2020-07-26T10:32:06.000Z
author: Martin
lastmod: 2020-07-26T10:32:06.000Z
tags:
- Images
- Manipulation
description: In this post I write about the creation of posters on the topic "resilient future". For that, I created a glitching algorithm in processing.
cover: /images/glitch_preview.png
---

I always wanted to write code that distorts images. I gave it a first shot with [processing](https://processing.org/).

The code applies three consecutive passes of distortion with differing strengths:

1. RGB noise moves the RGB values by different amounts
2. Pixel shift moves whole pixels up/down
3. Pixel scrumble moves whole pixels around

The strength of all three passes is `0` at the bottom of the image and increases to its max at the top of the image. The bottom also has a range where there is no distortion applied at all.

Due to the way the algorithm works, you can still clearly identify the kind of image from the bottom part. The most interesting part in my opinion is around the middle, while at the top it becomes unrecognizable for most inputs.

Below are two examples of what the outcome could look like. You can find the code that I wrote to generate these images on [GitHub](https://github.com/schemar/generative/tree/master/processing/glitch)[.](GitHub)

<figure>
  <div style="display: flex; flex-direction: row; justify-content: center;">
    <div style="flex: 0.8 1 0%;">
      {{< figure src="/images/giltch_1.jpg" position="left" >}}
    </div>
    <div style="flex: 0.8 1 0%; margin-left: 0.75em;">
      {{< figure src="/images/glitch_glitch_1.jpg_run_5-1.png" position="right" >}}
    </div>
  </div>
  <figcaption style="width: 100%; text-align: center; margin-top: -15px;">
    Photo by <a href="https://unsplash.com/@happyfaceemoji?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">H.F.E & CO</a>
    on <a href="https://unsplash.com/?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a>
  </figcaption>
</figure>

<figure>
  <div style="display: flex; flex-direction: row; justify-content: center;">
    <div style="flex: 0.75 1 0%;">
      {{< figure src="/images/glitch_2.jpg" position="left" >}}
    </div>
    <div style="flex: 0.8 1 0%; margin-left: 0.75em;">
      {{< figure src="/images/glitch_glitch_2.jpg_run_1.png" position="right" >}}
    </div>
  </div>
  <figcaption style="width: 100%; text-align: center; margin-top: -15px;">
    Photo by <a href="https://unsplash.com/@jgrospe?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Jeffrey Grospe</a>
    on <a href="https://unsplash.com/?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a>
  </figcaption>
</figure>

I used the glitch algorithm to create a series of posters on the topic of "resilient future". The idea behind it is that while the image glitches more and more towards the top (the future), the “Stay Resilient” lettering represents the original unglitched image; therefore being “resilient”. The original images belong to [Futurice](https://futurice.com/).

<figure>
  <div style="display: flex; flex-direction: row; justify-content: center;">
    <div style="flex: 0.7 1 0%;">
      {{< figure src="/images/resilient_3.jpg" position="left" >}}
    </div>
    <div style="flex: 0.7 1 0%; margin-left: 0.75em;">
      {{< figure src="/images/resilient_5.jpg" position="right" >}}
    </div>
  </div>
  <div style="display: flex; flex-direction: row; justify-content: center; margin-top: -30px;">
    <div style="flex: 0.7 1 0%;">
      {{< figure src="/images/resilient_6.jpg" position="left" >}}
    </div>
    <div style="flex: 0.7 1 0%; margin-left: 0.75em;">
      {{< figure src="/images/resilient_8.jpg" position="right" >}}
    </div>
  </div>
  <figcaption style="width: 100%; text-align: center; margin-top: -15px;">
    Stay resilient with Futurice
  </figcaption>
</figure>
