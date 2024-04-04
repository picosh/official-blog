---
title: New file types supported for pgs.sh
description: We are switching from allowlist to denylist
date: 2024-04-04
tags: [announcement, pgs]
---

Hey everyone!

After a handful of conversations on IRC, we decided our pgs allowlist was far
too narrow and limiting to the point where it impacts the UX of our service.

As a result, we are going to switch [pgs.sh](https://pgs.sh) from an allowlist
to a denylist.

# what does this mean for my site?

- Virtually all file types are supported!
- You should double check you are not accidentally uploading files you don't
  want publicly available

# denylist

We are denying any file or files inside a directory with a `.` as its first
character. Because all files uploaded to pgs are public-by-default, we felt like
the right thing to do was deny any and all dotfiles.

At the moment this denylist cannot be modified, but following soon will be the
ability to change this denylist in cases where it doesn't quite fit your use
case.

# when will this change take effect?

We plan to deploy sometime on 2024-04-05
