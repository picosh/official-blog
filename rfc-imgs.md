---
title: rfc 0002 imgs.sh
description: A proposal for imgs service
date: 2022-08-10
tags: [rfc]
---

The pico team has been thinking about a new premium image hosting service. We
haven't written a single line of code yet but have spent time thinking about it.
This document serves as our proposal not only for how the service ought to
function, but also details about the technical implementation.

# imgs the service

It's an image hosting service. Users will be able to upload their images along
with metadata about the image (e.g. title, caption, date, tags). The intention
is to store the images permanently until service is canceled.

This will be a paid service. We are considering a "pico pro" plan or just
charging for this service as a stand alone. More details on that later, but it's
enough to know that this will not be a service offered for free.

Based on [previous research](https://hey.prose.sh/imgs-market-research), and in
order to stay competitive with other image hosting services, we would need
similar features:

- No trial
  - If we do want to offer a trial, we delete the images after 10 minutes
- Permanent storage
- Public only
  - No private images allowed
- Hotlinking enabled
- Ad free
- No JS
  - But we don't want to sacrifice on UX so we might want to introduce a little
    bit of javascript, primarily with gallery views
- Nominal storage
  - We don't want to encourage whales here
  - We should limit the storage, somewhere in the range of 25-100GB

## the twist

SSH app to upload images and metadata. You should also be able to easily
download the images using ssh. All content management happens inside the
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

## photo albums

We also want to support photo albums on `imgs.sh`. To implement this feature, we
are leveraging tagging. So the user will be able to add tags to their image
which we will then aggregate into photo albums.

# why?

We think this service would be genuinely useful to terminal enthusiasts who want
to quickly take a pic and share it in chat or use it in a blog.

We also received a few questions asking about charging for our services in order
to help sustain it long term. No one wants to join a platform that then
disappears after a year. This really is a confluence of us wanting to host
images for our personal blogs, imagining others would find it useful, and also a
way to help support service costs and active development.

# moderation

This is not a "post whatever image you want without repercussions" image hosting
service. We will accept DMCA take down notices and we will ban users for posting
illegal images. I think we should also reject pornographic images.

Moderation is going to be the biggest time sink with this service so we need a
system in place to make it painless. In the beginning, I think we should have an
RSS feed of all images posted to `imgs.sh` and review them. If there is an image
posted that we deem inappropriate, we will remove the image and potentially ban
the user who published it.

We should also provide a reporting endpoint so users can report images for us to
review.

# closed beta

In the beginning the service will be online but closed to registration. To
enroll in the beta program, users **must** join our IRC channel and request an
invite. They will then be able to use the service for free while we tweak the
imgs for mass adoption. We will make no guarantees about uptime, service
reliability, or even the possibility that their images will be deleted.

# tos and privacy policy

We need to make sure we have these docs locked down since this will be a premium
service.

# technical details

I think we should build this to potentially support multi-region. But we would
implement this service similarly to our other services. I think we will be able
to leverage our CMS to handle most of the heavy lifting. Uploading an image
would use `scp` and we would store the image inside the `posts` table.

Then we would build out a web api for retrieving the images.

## third-party services interacting with imgs

Since we have a monorepo setup, we could pretty easily just reach into the code
for `imgs` inside `prose` and perform the necessary operations within `prose`.

We could also figure out a clean way to send the images to `imgs` using agent
forwarding or x509 certs. The "third-party service" (e.g. prose) would request a
certificate that they could use to send uploads to `imgs` on behalf of a user.

However, for the MVP, I think we should just use the code directly in our
services.

I do think it's important that services we don't control should still have a
path to using `imgs` that can upload images on behalf of a user.

## where do we host the files?

This is tricky. We could store the files to S3 or some other object storage, but
the costs are pretty high. We could store the files directly on our VM FS, but
we'd need to make sure we have enough space and it can scale. I'm going to defer
to Antonio for this section.

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
  trip-to-paris.md  # metadata for image
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

Inside `trip-to-paris.md` we would provide metadata for the image:

```md
---
title: Close up to the eiffel tower
date: 2022-08-04
tags: [paris]
caption: Eiffel tower, Tower in Paris, late morning.
---

## Day 1

We arrived in Paris around 5 AM. When we eventually found the place to pick up
our rented car, and got our first warning to "park facing the wind so you don't
lose your doors," we started towards the Eiffel tower. I looked out into the
darkness, mostly only able to see the slight embankments on both sides of the
road, and was reminded of Hawaii, where I was this time last year — large,
rolling hills all barren of trees.
```

It might seem weird that we have a description of the image in a separate
markdown file, but this metadata will also be posted to `imgs.sh` and not just
`prose`. A user doesn't have to add metadata to their image but it provides
potentially important information (e.g. tags, date) that could be useful on its
own inside the `imgs` service. We would pull that data into the blog post if it
exists.

Example: https://snap.as/matt/iceland/zUUoCon

Once the content is written, the user would upload all files to `prose`:

```bash
scp ~/blog/*.md ~/blog/*.jpg erock@prose.sh:
```

When we upload all the files, since we now have two markdown files that need to
go to different locations, we will need special logic:

- If there's an image, upload to `imgs`
- If there's a markdown file that matches the name of an image, upload to `imgs`
- Otherwise upload markdown files to `prose`

Now when a blog post is requested, we do a few things:

- Find the markdown post
- Scan for relative image urls
- Replace the URL with `imgs.sh` url
- Also query for the metadata
- Embellish the markdown with metadata
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

[![Close up to the eiffel tower](https://erock.imgs.sh/trip-to-paris.jpg)](https://erock.imgs.sh/trip-to-paris)
_Eiffel tower, Tower in Paris, late morning._

## Day 1

We arrived in Paris around 5 AM. When we eventually found the place to pick up
our rented car, and got our first warning to "park facing the wind so you don't
lose your doors," we started towards the Eiffel tower. I looked out into the
darkness, mostly only able to see the slight embankments on both sides of the
road, and was reminded of Hawaii, where I was this time last year — large,
rolling hills all barren of trees.

It's a tourist trap but we couldn't resist checking it out.
```

Adding the markdown from the metadata file into the blog post might be overkill
and be awkward so we could get rid of it. My guess is whatever is inside the
metadata file should be rendered in the blog post but that's something we can
discuss.
