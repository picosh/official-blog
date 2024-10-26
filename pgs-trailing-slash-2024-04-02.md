---
title: Pages redirect to trailing slash
description: 301 redirect to trailing slash
date: 2024-04-02
tags: [ann]
---

Greetings!

This feels like a significant enough change to submit a post about it.

We will be deploying a change today to the default routing behavior for
[pgs.sh](https://pico.sh/pgs).

Previous behavior:

- `/subcategory`
- `/subcategory/index.html` (implicit)

New behavior:

- `/subcategory`
- `[301] /subcategory/`
- `/subcategory/index.html` (implicit)

As illustrated, we will be performing a `301` permanent redirect when a
directory is discovered without a trailing slash. This is very common for file
servers and other popular static site hosting platforms.

Currently, there is no way to disable "pretty urls" in pages, but if users
request it we will provide a way to disable them on a per-site basis.

- [PR](https://github.com/picosh/pico/issues/115)
- [GH Issue](https://github.com/picosh/pico/issues/115)

Hopefully no one will be impacted by this change, but you might want to prevent
the permanent redirects in your static sites by always providing a trailing
slash to directories.
