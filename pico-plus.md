---
title: pico+
description: Premium pico services
date: 2024-02-18
tags: [announcement]
---

Greetings.

After a year+ of work we have finally reached a point where we feel comfortable
offering a set of premium paid services.

[pico+](https://pico.sh/plus)

The premium services we offer are going to continue to evolve over time, but for
right now there are **(3)**:

- [pgs.sh](https://pico.sh/pgs) - zero-install static site hosting
- [tuns.sh](https://pico.sh/tuns) - ngrok alternative using SSH tunnels
- [imgs.sh](https://pico.sh/imgs) - docker image registry using SSH tunnels

A lot of work has gone into these services, but they are far from perfect.

> Done is better than perfect

We cannot guarentee 100% service reliability or that it will work exactly as you
expect it to. However, we can gaurentee that we will do our best to ensure
availability. Further, we only support services that we use ourselves.

# why?

These are services we want to use. We think they offer fantastic DX and we use
them everyday. What better way to maintain these services than to up them up for
other hacker to use? Further, these services are not free to support, and the
more users we have, the most expensive they will be to maintain.

We have also received feeback from users that they want a way to "support"
pico.sh development. We could have offered a way to donate to us, but we felt
like offering concrete services offered a better incentive structure for us and
users.

# hacker labs

[Lab](https://pico.sh/lab) is where we will showcase experimental ideas,
projects, and oss libs.

As a result of our premium services, we wanted to also make some of the
underlying tech more accessible for public use.

In particular, we want to callout two recent additions:

- [ptun](https://github.com/picosh/ptun) - `rsync`, `scp`, `sftp` for your
  object store
- [pobj](https://github.com/picosh/pobj) - passwordless authentication
  experience for the browser

We think these two libraries are actually pretty exciting and they have been
sitting right in front of us, waiting to be discovered. Try them out, let us
know what you think.
