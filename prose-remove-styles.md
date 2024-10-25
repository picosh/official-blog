---
title: rfc-6 prose remove styles
description: Remove the default styles on prose for better customization
date: 2024-10-01
tags: [rfc]
---

We just deployed a new feature for `prose` that we think is worth an
announcement. We care about [radical experimentation](/radical-experimentation)
at pico and want to continue to make potentially dramatic changes to the look
and function of our services. For many of our services, this is not much of an
issue. However for `prose`, things are a little different when it comes to the
look and feel of a person's blog. We don't want to make dramatic changes to our
theme over time without being careful.

As a result, we are giving users an escape hatch to define the look and feel of
their blog's styles.

[`with_styles`](https://pico.sh/prose#with-styles) allows users to disable our
default CSS styles entirely. That along with the user-defined `_styles.css`, it
should make it easier to customize your blog.

Just send us a `_readme.md` file with the following setting:

```md
---
with_styles: false
---
```

Further, we plan to make some bigger changes to the default styles on prose. You
can see what it will look like at [bower.sh](https://bower.sh).

If you want your blog to have the same style as it exists today, disable the
default styles `with_styles: false` like above and then download the current
version of our styles:

```bash
curl -o ./_styles.css https://prose.sh/smol.css
scp ./_styles.css prose.sh:/
```
