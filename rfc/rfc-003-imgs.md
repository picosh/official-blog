---
title: rfc-3 image hosting
description: A proposal for an image hosting service
date: 2022-08-11
tags: [rfc]
---

The pico team has been thinking about a new image hosting service. We haven't
written a single line of code yet but have spent time thinking about it. This
document serves as our proposal not only for how the service ought to function,
but also details about the technical implementation.

# images as a service

It's an image hosting service. Users will be able to upload their images and it
will be instantly publicly sharable, including hotlinking. Further we will
support an image manipulation API which will be awesome for quick tweaks to
width and height ratio, quality, rotation, etc. The intention is to store the
images permanently until service is canceled.

Based on [previous research](https://blog.pico.sh/imgs-market-research), and in
order to stay competitive with other image hosting services, we would need
similar features:

- Permanent storage
- Public only
  - No private images allowed
- Hotlinking enabled
- Ad free
- Nominal storage
  - We should limit the storage per user

## the twist

scp, rsync, sftp to upload images. All content management happens inside the
terminal and with a key pair. Our target audience are people that are
comfortable with the terminal.

The default route to the image would be optimized for the device requesting to
view the image. We would read the `User-Agent` to try to understand the device
and then change the quality and resolution based on that information.

We would also provide ways to specify:

- width
- height
- preserve aspect ratio
- quality
- original image

We would also seamlessly integrate with any of the services we create that could
benefit from sharing images.

This service would be all about sharing media with other people, that's why it's
public only. We don't want to be a data warehouse for all personal media.

# why?

We think this service would be genuinely useful to terminal enthusiasts who want
to quickly take a pic and share it in chat or use it in a blog.

# moderation

This is not a "post whatever image you want without repercussions" image hosting
service. We will accept DMCA take down notices and we will ban users for posting
illegal images. In particular we have a
[Code of Content Publication](https://pico.sh/ops#code-of-content-publication)
that we must maintain.

Moderation is going to be the biggest time sink with this service so we need a
system in place to make it painless. In the beginning, I think we should have an
RSS feed of all images posted to `imgs` and review them. If there is an image
posted that we deem inappropriate, we will remove the image and potentially ban
the user who published it.

We should also provide a reporting endpoint so users can report images for us to
review.

# technical details

I think we should build this to potentially support multi-region. But we would
implement this service similarly to our other services. I think we will be able
to leverage our CMS to handle most of the heavy lifting. Uploading an image
would use `scp` and we would store the image inside the `posts` table.

Then we would build out a web api for retrieving the images.

## third-party services interacting with imgs

Since we have a monorepo setup, we could pretty easily just reach into the code
for `imgs` inside `prose` and perform the necessary operations within `prose`.

## where do we host the files?

This is tricky. We could store the files to S3 or some other object storage, but
the costs are pretty high. We could store the files directly on our VM FS, but
we'd need to make sure we have enough space and it can scale. We decided to
self-host a [minio](https://github.com/minio/minio) instance for our object
storage service.

## integration with pico services

The entire point of this service is to enhance our pico services with image
hosting capabilities, so it's critical we figure out the ergonomics of
integration this service with pico.

Ideally, the user would be able to upload images on `prose` and we would reach
out to the `imgs` service to store them. Once the image has been uploaded to
`imgs` any reference to the image would be swapped at runtime inside `prose`.

Let me demonstrate an example workflow inside a `prose` blog:

User's blog folder at `~/blog`:

```bash
blog/
  trip-to-paris.jpg # image to upload to imgs
  tour-to-paris.md  # blog post that contains reference to image
```

Inside `tour-to-paris.md` we would have something like:

```md
---
title: My trip to paris!
---

My trip was great! Here is a pic from my trip

![](/trip-to-paris.jpg)

It's a tourist trap but we couldn't resist checking it out.
```

Once the content is written, the user would upload all files to `prose`:

```bash
scp ~/blog/*.md ~/blog/*.jpg erock@prose.sh:
```

Now when a blog post is requested, we do a few things:

- Find the markdown post
- Scan for relative image urls
- Replace the URL with `imgs.sh` url
- Convert markdown to HTML

Before:

```md
---
title: My trip to paris!
---

My trip was great! Here is a pic from my trip

![](/trip-to-paris.jpg)

It's a tourist trap but we couldn't resist checking it out.
```

After:

```md
---
title: My trip to paris!
---

My trip was great! Here is a pic from my trip

![](https://erock.imgs.sh/trip-to-paris.jpg)

It's a tourist trap but we couldn't resist checking it out.
```
