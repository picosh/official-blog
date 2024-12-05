---
title: status-10
date: 2024-11-07
tags: [status]
---

Greetings.

Sometimes it's really hard to rise to the surface for air when we are having so
much fun writing code.

We recently released a new service, [pipe](https://pipe.pico.sh), which is
exciting. It fits nicely into the services we want to build and maintain. It's
easy-to-use, lightweight, can saturate a gigabit internet connection, and solves
a real problem: securely sending and receiving events across a network. We are
slowly [building libraries](https://github.com/picosh/pipe-py) with easy-to-use
APIs for interacting with `pipe`.

This is what we love about hacking on pico. We have a singular focus here: to
build tools and services we **need** to use. Antonio built
[sish](https://github.com/antoniomika/sish) because he needed to expose local
services to the internet. I built [pages](https://pico.sh/pgs) because I needed
an easy way to deploy static sites.

While we delight in people thinking what we build is cool, that's not why we are
building this platform. We build and maintains services for primarily ourselves
and then as a result we know other devs want to use them as well.

This leads into something else we have been thinking about lately. Our
"subscription" service is not actually a subscription. It's something users have
to purchase every year. We recently asked ourselves this question: why aren't we
letting users automatically subscribe to pico+ every year?

This is important. We need a forcing function to make our services the best
versions of themselves. This function includes a bunch of inputs, but in
particular, one of them is a user explicitly re-purchasing pico+. If a user
doesn't notice that they forgot to resub, then they aren't using our services
like we want. We need strong signals to know which direction to go.

Another input is `pico+` signups per month. Last month we hit a new personal
record for most signups in a month. Exciting!

Onto `pages` which has been pretty active in terms of development. A recent user
posted some explorations into
[improving pgs asset serving performance](https://github.com/picosh/pico/issues/149)
which has sparked a bunch of refactor work on the code itself. We have better
test coverage and are slowly detaching `pages` code from the rest of our
services. We see `pages` breaking out and being its own isolated project so we
can continue to make it better than ever.

We also reformatted our blog to be more structured. We are experimenting with
the idea of making our blog more of a living document. So on our index page, be
sure to click on the different topics, as we are going to be start updating
them.

There's more -- like all my work on [git-pr](https://pr.pico.sh) -- but I'm
going to save that for a future [ann](/?tag=ann) post.
