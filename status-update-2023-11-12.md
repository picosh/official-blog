---
title: status-3
description: New features and services
date: 2023-11-12
tags: [status]
---

Hey everyone!

I figured it was time to write another update on what we are working on at pico
headquarters.

# A wild company appears

Firstly, we created a company: `pico.sh LLC`. We will be slowly updating all the
documentation to mention the company across all of our services and sites.

The reason we created an LLC is because we plan to offer paid services, starting
with [pgs.sh](https://pgs.sh) and [tuns.sh](https://tuns.sh).

We are still figuring out all the details but we are slowly building the billing
and pricing engines to support what we are tentatively calling `pico pro`.

If you are interested in reading more about `pico pro` then feel free to read
our latest [RFC for pico pro](/rfc-pico-pro-2023-11-06).

# Data transfer updates

We want to make it as easy for users to transfer files (whether it is prose
posts, imgs, or static sites) to pico. With that effort comes a couple
delightful changes we recently deployed to all our services.

## Better `sftp` support

We now fully support SFTP to data transfer, including connecting to any of our
services using SFTP. For example:

```
sftp prose.sh
```

This will drop you into an interactive terminal where you can manipulate your
blog posts!

## Better `rsync` support

[pgs.sh](https://pgs.sh) is a zero-dependency static site hosting service for
hackers. `pgs` requires recursive uploads of static files and with it comes
better integration between pico and `rsync`.

With `pgs` users can now run the following command to recursively deploy a
static site:

```
rsync -rv src/ <user>@pgs.sh:/<project>
```

With this work we also made it possible to only upload files that have changed
between `src` and `dest`.

We also improved error handling when a user attempts to use an `rsync` option
that isn't supported (e.g. compression is not supported).

# IRC bouncer and chat client

If you didn't already know, we use IRC for all of our comms. Antonio and I are
very active in #pico.sh. We also recently deployed an IRC bouncer and web chat
client free to all pico users. We know IRC has some rough edges when it comes to
persisting chat history and "always only" functionality so we decided to
self-host an IRC bouncer (`soju`) and a web client (`gamja`) to make it easier
for users to participate in the pico ecosystem.

Please [read the previous blog post](/pico-bouncer-and-web-client) on using pico
to connect to these services.

# `pastes.sh` updates

[pastes.sh](https://pastes.sh) is the easiest to use a pastebin on the planet.
You don't need to install any tools, all you need is an SSH key loaded into pico
and you have the ability to upload files or content into our pastebin.

We have been experimenting with different ways to manage content in the pico
ecosystem without requiring a user login and password. With this comes SSH
commands. We have always supported the ability for users to pipe contents to
[pastes.sh/help#pipe](https://pastes.sh/help#pipe).

```bash
echo "hi there" | ssh pastes.sh hello.txt
```

But now we support the ability to:

- Set expiration date (or even never expire a paste)
- Set the paste to unlisted (e.g. hidden)

```bash
echo "hi there" | ssh pastes.sh hello.txt expires=false
echo "hi there" | ssh pastes.sh hello.txt expires=1h
echo "hi there" | ssh pastes.sh hello.txt hidden=true
echo "hi there" | ssh pastes.sh hello.txt expires=10d hidden=true
```

Try it out and let us know what you think!

# `prose.sh` style updates

As you can see with this post, we have updated some of the styles on
[prose.sh](https://prose.sh). The primary changes were to make headers a little
more obvious when scrolling through a blog post with many different heading
sizes. This gives our headers a little more impact and stand out more when
reading a post.

# Web Tunnels

Finally, we think we have stumbled upon a brand new way to authenticate users
for the web.

> What if you could use an SSH key to log into a website?

This has been attempted before, and Chrome's `passkeys` are a step in that
direction, but it requires browser specific APIs to be implemented. Further
there's no way to backup your `passkeys` except for company sanctioned
mechanisms like iCloud. This sucks for the end-user because they don't own the
keys. This feature is clearly targeting non-developers. We think we have a
mechanism to support passwordless logins while still keeping the user in
control. Further, we think this new mechanism could also allow users to
authenticate to pico services on their mobile devices.

We are still in the planning phase, but keep an eye out for more information on
this topic as we slowly begin to tease a revolutionary new authentication
mechanism for the web, just for developers.

# We are just getting started

We are excited to get these changes out to users because we love using pico
services; we use them everyday. We hope you enjoy them as well and would love
any feedback from the pico community.
