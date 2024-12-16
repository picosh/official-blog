---
title: pgs.sh http caching
description: Your pages sites are now faster than ever
date: 2024-12-16
tags: [ann]
---

We recently deployed an HTTP caching[^1] layer for pages[^2], lead by Mac
Chaffee[^3].

All pages sites are now **blazing** fast -- sorry, I had to say it.

With HTTP caching we need a way to automatically and manually clear the cache.
Whenever a user updates their site we will wipe the cache for it. Further, we
also provide a remote CLI to let users clear their cache manually:

```bash
ssh pgs.sh cache {project} --write
```

We are still working through the feature-set for HTTP caching but we think we
landed on something that should cover our use cases for awhile.

> If anyone notices their site not updating when it should, please let us know
> so we can investigate.

# impl

Finding an off-the-shelf http caching service was not exactly straight-forward.
We spent a considerable amount of time experimenting with various techniques.
First we tried caching within our pages service, then decided that it might be
better to put it inside our reverse proxy (caddy), and then ultimately decided
to put it back inside of our pages service.

There are only a handful of Go http caching libraries and most of them have been
archived. It seems, that fully implementing RFC7234[^4] is non-trivial and hard
for open-source contributors to maintain.

Thankfully we found souin[^5] which we can plainly see has had a ton of work put
into it. Kudos, darkweak, your hard work on this library was much appreciated --
I really didn't want to implement RFC7234[^4] myself.

Like everything else at pico, we are always looking for ways to dogfood our
services. The cache clearing mechanism mentioned at the beginning of the post
was enabled by pipe[^6], which is our authenticated, networked `*nix` pipes
service.

We created a pipe topic `cache-drain` where we send all requests to clear
caches. Then we have a function that subscribes to the `cache-drain` and clears
our HTTP cache.

What's really nice is our observability over the cache drain. We now have a
single channel where we can view all requests being sent through our
`cache-drain`:

```bash
ssh pipe.pico.sh sub cache-drain
```

During development, it was very easy for us to test this system because we can
just clear any HTTP cache through the topic:

```bash
echo 'erock-neovimcraft' | ssh pipe.pico.sh pub cache-drain
```

That's it!

[^1]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Caching

[^2]: https://pgs.sh

[^3]: https://www.macchaffee.com/

[^4]: https://datatracker.ietf.org/doc/html/rfc7234

[^5]: https://github.com/darkweak/souin
