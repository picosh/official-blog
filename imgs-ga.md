---
title: imgs.sh launch
description: image hosting site for hackers
date: 2022-10-06
tags: [announcement]
---

![stable-diffusion: art exhibit by Akihito Yoshida, colorful universe](/imgs-launch)
_stable diffusion: art exhibit by Akihito Yoshida, colorful universe_

Hey everyone! Team pico is excited to announce the general availability of our
image hosting service, [imgs.sh](https://imgs.sh).

We have been working on `imgs` for a few months now, figuring out the best way
to handle uploading images from our blogs while at the same time being its own
separate service. We've been using it for our own personal blogs with great
success so we're excited to release it for public use.

If you already have a pico account, then you already have access to `imgs`.

## Features

- Delightful terminal workflow
- Share public images from the terminal
- Seamless integration with other pico services (e.g. prose)
- Images are web optimized by default
- API to modify images on-the-fly (e.g. dimensions)
- Hotlinking encouraged!
- No javascript
- No ads
- 10MB max file size
- 1GB max storage

You also don't need to use our other pico services to be able to use imgs. Just
`scp` or `rsync` like you normally would but to `imgs.sh`

```
scp profile.jpg name@imgs.sh:/
```

## How does it work?

When a user uploads an image, we immediately convert it to `webp`. Then we have
an API that serves those web optimized images. We also allow for minimal image
manipulate -- like resizing images.

```
[!profile](/profile/x500)     # auto scale width
[!profile](/profile/500x500)  # scale width and height
[!profile](/profile/500x)     # auto scale height
```

Also be sure to read our [help page](https://imgs.sh/help#integrations) for more
info

We'd love to get feedback on the service so please give it a try and let us know
what you think.
