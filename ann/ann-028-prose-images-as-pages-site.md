---
title: prose images as pages site
description: we migrated prose images to an auto-generated pages site
date: 2025-01-18
tags: [ann]
---

![Lawyer's Club at the University of Michigan](/lawyers-club.jpg/x350)

The reason for this change was mainly internal cleanup but as a result we are automatically generating a [pages](https://pico.sh/pgs) site (`prose`) for [prose](https://prose.sh) blog images. This setup has some benefits:

- Every user has a single "bucket" for static assets
- Images can be viewed, managed through a pages site

There's really only one caveat: if you change the `prose` site (e.g. upload or delete images) it'll change what prose can access. Further, if you upload images to it then you'll be able to reference them in your blog post.

In an effort to prevent a foot-gun, we are **not** allowing users to delete the project itself.

Since prose is now "hosting" its images on pages, we have combined the storage limits for the pico platform into a single "bucket." We are continuing to experiment with how much storage we allow for users, both free and `pico+`. Eventually we would like to be in a position where we don't have to limit storage, but we aren't there yet. If the new storage limit is an issue for you, please feel free to [message us](https://pico.sh/contact).
