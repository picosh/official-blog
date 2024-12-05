---
title: rfc-4 pico+
description: What does charging for services look like for us?
date: 2023-12-31
tags: [rfc]
---

|                  |                      |
| ---------------- | -------------------- |
| **status**       | published            |
| **last updated** | 2024-12-04           |
| **site**         | https://pico.sh/plus |

# mission statement

We want to build tools and services that are useful for software development. We
want to empower individual contributors to rapidly prototype and boost
productivity. We want to enable homelabs with the ability to host public web
services.

# design goals

- It's something we (team pico) need to use
- Developer tools and services
- Focus on individual and small developer teams
- Enable developers to rapidly prototype
- Ability to host small web services
- Leverage SSH

# what it is not

- Not a PaaS
- Not designed for large organizations

# services

- static site hosting [pgs.sh](https://pgs.sh)
- tunnels as a service [tuns.sh](https://tuns.sh)

## static site hosting

An easy to use static site hosting platform. Publish your sites as easy as
copying files to our SSH app.

## tunnels as a service

Get automatic TLS for web services hosted locally. This includes tcp,
websockets, and http.

# pricing

$2/mo billed annually.

We would like to keep pricing as simple as possible to reduce overhead. The
current idea is we only offer a yearly subscription service. Ideally we would be
able to charge somewhere around $20/yr, but that might change depending on how
much compute we offer users.
