---
title: shutting down our docker image registry service
description: A service that no one used
date: 2025-01-09
tags: [ann]
---

With the new year comes with us killing another service. This is a service we quietly removed from our docs just to see if anyone would notice: no one did.

We have a litmus test at pico: if we don't find ourselves using a service then we kill it.

We thought having a docker image registry that leveraged SSH could be a really useful service. One that could always be authenticated as long as an SSH tunnel was active.

Well unfortunately, we saw very little usage and because it relied on an SSH tunnel, it ended up being kind of slow. It also only worked for private images -- because you had to be authenticated to access it -- which is not super common for open source or hacker projects.

> We will be shutting down imgs.sh on 2025/01/17

For the few people that are still using this service, we apologize for the inconvenience and since this was a `pico+` service, email us and we can discuss a partial refund or an extension to `pico+`.
