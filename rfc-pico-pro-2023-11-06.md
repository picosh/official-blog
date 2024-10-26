---
title: rfc-3 pico+
description: What does charging for services look like for us?
date: 2023-12-31
tags: [rfc]
---

# Mission statement

We want to build tools and services that are useful for software development. We
want to empower individual contributors to rapidly prototype and boost
productivity.

# Design goals

- Primary directive is to be useful to ourselves
- Developer tools and services
- Focus on the individual developer
- Enable developers to rapidly prototype
- Ability to host small web services
- Authentication with SSH
- Move fast and break things

# What it is not

- Not a PaaS
- Not designed for teams or organizations
- Not going to provide 99.99% uptime
- It's not going to scale with demand

# Services

- static site hosting [pgs.sh](https://pgs.sh)
- tunnels as a service [tuns.sh](https://tuns.sh)
- [distrobox](https://github.com/89luca89/distrobox) as a service
- docker compose as a service
  [pcompose](https://github.com/antoniomika/pcompose)

## static site hosting

An easy to use static site hosting platform. Publish your sites as easy as
copying files to our SSH app.

### TODO

- Figure out storage, bandwidth limits

## distrobox as a service

Create a development container in the cloud. Use familiar linux distros. Remote
into your dev container from any client.

### TODO

- One big benefit of distrobox is that it lets you mount your home directory
  - Do we want to support persistent disk for distrobox containers?
  - That way a user can spin up as many containers as they want and they have
    the same persisted home directory
- Many developers need access to Docker, which is a technical challenge
- Could we link this service with our docker compose one?
- For example, I could have a distrobox with arch but I need a postgres server
  and I'd like to run it inside a docker container
  - I know there's a way to proxy docker commands to a remote docker daemon, I
    wonder if we could leverage that here?
- How many containers do we want to support?
- Do we want to provide an ephemeral version of this? (e.g. `docker run --rm`)
- Do we want to automatically load remote vscode?

## docker compose as a service

If all you need is a place to host your simple services, use docker compose.
This service is not designed to scale, rather, a quick place to get services up
and running with minimal effort. This service is also great for rapidly
prototyping and getting a product or service out-the-door quickly.

### TODO

- How do we handle network isolation?
- How do we charge?
- How do we technically allow pcompose to be multi-tenant?
- Should we provide officially supported images for some apps/services/tools?
  - git repos
  - image registry
  - CI/CD
- How many distinct docker compose files should we support?
  - Current thinking is just one but that might be limiting

## tunnels as a service

Need to access `localhost` from `https`? Not only that, but we also use tunnels
to allow you to connect to all your other containers.

### TODO

- Can we leverage tuns for network isolation?
- Can we leverage tuns to connect to all user containers?
- Can we leverage tuns for web tunnels?

# Pricing

We would like to keep pricing as simple as possible to reduce overhead. The
current idea is we only offer a yearly subscription service. Ideally we would be
able to charge somewhere around $20/yr, but that might change depending on how
much compute we offer users. I think we could implement a tier pricing model but
that is kind of a pain. It would be better if there was just one single plan
that works for most users.

### TODO

- How much do we want to charge users?
- How much compute do we want to offer users?
- Do we want to allow users to horizontally scale their compute?
- Do we want to allow users to vertically scale their compute?
