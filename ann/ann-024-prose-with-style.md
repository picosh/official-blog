---
title: prose with style
description: Providing stability through radical experimentation
date: 2024-10-01
tags: [ann]
aliases:
  - rfc-007-prose-with-style
---

We just deployed a new feature for `prose` that we think is worth an
announcement. We care about [radical experimentation](/radical-experimentation)
at pico and want to continue to make potentially dramatic changes to the look
and function of our services. For many of our services, this is not much of an
issue. However for `prose`, things are a little different when it comes to the
look and feel of a person's blog. We don't want to make dramatic changes to our
theme over time without being careful.

We need to have a paradigm shift with our services and `prose` is a great
vehicle to discuss stability through our radical experimentation.

For `prose`, we are giving users a way to define the look of their blog without
the default CSS. [`with_styles`](https://pico.sh/prose#with-styles) allows users
to disable our default CSS styles entirely. That along with the user-defined
`_styles.css`, it should make it easier to customize your blog.

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

This post is not exclusive to `prose`. We need to make our design philosophy
aligned with radical experimentation. We need to provide users with stability
and consistency while also making dramatic changes to them.
