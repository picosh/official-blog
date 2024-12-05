---
title: rfc-3 image hosting
description: A proposal for an image hosting service
date: 2022-08-11
tags: [rfc]
---

|                  |                        |
| ---------------- | ---------------------- |
| **status**       | published              |
| **last updated** | 2024-12-04             |
| **site**         | https://pico.sh/images |

We want to provide an image hosting service.

This document serves as our proposal for how image hosting ought to function and
details about the technical implementation.

# images as a service

It's an image hosting service. Users will be able to upload their images and it
will be publicly sharable, including hotlinking. Further we will support an
image manipulation API which will be awesome for quick tweaks to width and
height ratio, quality, rotation, etc. The intention is to store the images
permanently until service is canceled.

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

Uploading an image would use [file uploads](https://pico.sh/file-uploads) and we
would store the image inside the `posts` table.

Then we would build out a web api for retrieving the images.

For image manipulation, we can use
[imgproxy](https://github.com/imgproxy/imgproxy).

## where do we host the files?

We could store the files to S3 or some other object storage, but the costs are
pretty high. We could store the files directly on our VM FS, but we'd need to
make sure we have enough space and it can scale. We decided to self-host a
[minio](https://github.com/minio/minio) instance for our object storage service.

## integration with pico services

The entire point of this service is to enhance our pico services with image
hosting capabilities, so it's critical we figure out the ergonomics of
integration this service with pico.

So when you upload an image to [prose](https://prose.sh) or
[pages](https://pgs.sh), we use the same functionality for storing and
manipulating images.
