---
title: imgs.sh launch
description: image hosting site for hackers
date: 2022-10-06
tags: [imgs, service]
---

![stable-diffusion: art exhibit by Akihito Yoshida, colorful universe](/imgs-launch)
_stable diffusion: art exhibit by Akihito Yoshida, colorful universe_

Hey everyone!  Team pico is excited to announce the general availability of our
image hosting service, [imgs.sh](https://imgs.sh).

We also wanted to support the ability for our blogs to upload images but
weren't exactly sure how to do it.

If you already have a pico account, you have everything you need to start
uploading images with your blogs!

You also don't need to use our other pico services to be able to use imgs.
Just `scp` or `rsync` like you normally would but to `imgs.sh`

```
scp profile.jpg name@imgs.sh:/
```

## Features

-  Delightful terminal workflow
-  Share public images from the terminal
-  Seamless integration with other pico services (e.g. prose)
-  Images are web optimized by default
-  API to modify images on-the-fly (e.g. dimensions)
-  Hotlinking encouraged!
-  No javascript
-  No ads
-  No file size limits
-  1GB max storage

## Image resizing

```
[!profile](/profile/x500)     # auto scale width
[!profile](/profile/500x500)  # scale width and height
[!profile](/profile/500x)     # auto scale height
```

We have some other ideas for imgs but we wanted to get the MVP launched before
continuing feature development.

Also be sure to read our [help page](https://imgs.sh/help#integrations) for more info

We hope you enjoy!
