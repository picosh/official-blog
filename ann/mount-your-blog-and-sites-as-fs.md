---
title: mount your blog and sites as a fs
description: pico officially supports sshfs
date: 2024-06-16
tags: [ann]
---

We are excited to announce our official support for
[sshfs](https://github.com/libfuse/sshfs).

`sshfs` will allow users to mount their blog and sites like any other drive. So
you'll be able to view, edit, create, remove, and move folders and files like a
normal filesystem!

Some use cases we think are impactful:

- Debug production sites
- Run cli commands on your production sites
- Grep/find files across all your sites
- Create a development site that you use as a pgs dev server
- Make quick edits to a blog post live
- Run a formatter on your blog posts
- Easier and faster than git-ops (add+commit+push+wait-for-cicd)

# usage

First your need to install `sshfs`.

## blog with prose

mount your prose.sh blog:

```bash
mkdir ~/blog
sshfs prose.sh:/ ~/blog
# edit files using your favorite editor
nvim ~/blog/hello-world.md
# changes are published live!

# unmount
umount ~/blog
```

## sites with pages

mount your pgs.sh sites:

```bash
mkdir ~/sites
sshfs pgs.sh:/ ~/sites
# edit files using your favorite editor
nvim ~/sites/myproj/index.html
# changes are published live!
```

mount a single site:

```bash
# image you have a static-site builder
cd ~/my_site
# mount your ssg's output folder
sshfs pgs.sh:/my_site ./public
# edit files using your favorite editor
nvim tmpl/base.html
# run ssg build command
# changes are published live!
```

So what's the downside? Well it's a little slower than a hard drive on your
machine. We are still experimenting with the technology so quirks or bugs might
come up. We would love to get your feedback.

We will be updating our docs to include `sshfs` as an option for managing your
blog and sites.
