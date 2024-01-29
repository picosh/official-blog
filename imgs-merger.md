---
title: imgs.sh merger
description: We are merging imgs.sh and prose.sh
date: 2024-01-29
tags: [announcement]
---

# Summary

- **2024-01-30**:
  - imgs.sh merging with prose.sh
  - upload images to either prose or pgs.sh
  - all images on imgs are now available on prose
  - removing all blog web views on imgs
- **2024-02-05**: shutting down imgs.sh SSH server
- **2024-07-20**: shutting down imgs.sh web server

# Rationale

As we are getting closer to general availability with [pgs.sh](https://pgs.sh)
-- our static site hosting service -- we see having a separate-but-very-similar
service like **imgs.sh** as a distraction and confusing to users. So we are
merging imgs into [prose.sh](https://prose.sh). You were always able to upload
images directly using prose, but now instead of returning the imgs.sh URL, we
return a prose one. We also plan on immediately removing all web views that
existed on imgs.sh. We may add a way on prose to see all your blog images since
I do think that view is useful, but that's it.

So users of prose can continue to host their blog images on prose and all images
that were hosted on **imgs.sh** will be available on prose. We will have a grace
period where we will still serve hotlinks from **imgs.sh** but we will
completely shut down imgs.sh on **2024-07-20**.

As part of this merger we bring to both prose and pgs the ability to manipulate
their images on-the-fly. Image resizing is still supported thanks to
[imageproxy](https://github.com/willnorris/imageproxy) and we might open up more
of the image proxy features in the future.

We hope this isn't much of an inconvenience to pico users and are happy to chat
about it.
