---
title: Database migration incoming
description: we're merging our services' databases
date: 2022-07-28
tags: [migration]
---

Greetings travelers!

We wanted to give everyone a quick update on what's cooking at team pico.

We had some interesting discussions in irc about some new services that we are
building. Out of those conversations we decided it would be best for us to
restructure our services. In particular, we decided to merge all services'
databases into a single `pico` database.

The three services are:

- [prose](https://prose.sh)
- [lists](https://lists.sh)
- [pastes](https://pastes.sh)

Currently each service gets their own postgres database. There has been zero
drift between the table schemas and it will enable us to build a more cohesive
ecosystem. One big benefit is we will have a single users table so picking a
username only needs to happen once.

## Downside

The biggest downside to this change is that we have to resolve any username
collisions between the three services. We decided the best course of action with
a multi-phased approach:

- Step 1: try to resolve conflicts by comparing public_keys for an exact match
- Step 2: if we could **not** cleanly merge two users, then change the name of
  the lists.sh user to be `<username>tmp`
- Step 3: Update any references of a merged user to their new user record

Out of the 1200+ users, the end result is 32 conflicts we couldn't resolve.

Sometime today we plan on performing the migration and for most of the users,
they shouldn't notice a difference at all. For the 32 of you that have a name
collision: if you want to log into your lists account and it doesn't work, try
adding `tmp` to the end of it. At that point you are free to change your name or
keep it.

We apologize for this inconvenience and would love to read your thoughts about
the migration. Feel free to join
[#pico.sh on libera](irc://irc.libera.chat/#pico.sh) or email us at
[hello@pico.sh](mailto:hello@pico.sh).

## Wrap up

Like I mentioned above, we've got a
[bunch of services planned](https://todo.sr.ht/~erock/pico.sh?search=status%3Aopen%20label%3A%22service%22)
and we're very excited to see what gets everyone excited!
