---
title: rfc-4 pico+
description: What does charging for services look like for us?
date: 2023-12-31
tags: [rfc]
---

# mission statement

We want to build tools and services that are useful for software development. We
want to empower individual contributors to rapidly prototype and boost
productivity.

# design goals

- Primary directive is to be useful to ourselves
- Developer tools and services
- Focus on individual and small developer teams
- Enable developers to rapidly prototype
- Ability to host small web services
- Authentication with SSH

# what it is not

- Not a PaaS
- Not designed for large organizations
- Not going to provide 99.99% uptime

# services

- static site hosting [pgs.sh](https://pgs.sh)
- tunnels as a service [tuns.sh](https://tuns.sh)

## static site hosting

An easy to use static site hosting platform. Publish your sites as easy as
copying files to our SSH app.

## tunnels as a service

Need to access `localhost` from `https`? Not only that, but we also use tunnels
to allow you to connect to all your other containers.

# pricing

We would like to keep pricing as simple as possible to reduce overhead. The
current idea is we only offer a yearly subscription service. Ideally we would be
able to charge somewhere around $20/yr, but that might change depending on how
much compute we offer users. I think we could implement a tier pricing model but
that is kind of a pain. It would be better if there was just one single plan
that works for most users.
