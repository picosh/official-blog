---
title: Status update, July first
description: A new month with active development
date: 2022-08-01
---

Hey everyone!

I wanted to send out a quick status update to let people know what we are
working on.

We started this month off with a big refactor. This update is mostly code
organization related. Previously, all of our services (lists, prose, and pastes)
were separate repos. This worked well in the beginning because we didn't know
what our services were going to look like and how different they'd end up being
from each other.

Well, it turns out the three services we have deployed so far are very similar
to each other.

Since we had three examples, we executed the
[Rule of Three](http://en.wikipedia.org/wiki/Rule_of_three_%28computer_programming%29)
principle:

```
Rule of three is a code refactoring rule of thumb to decide when a replicated
piece of code should be replaced by a new procedure. It states that the code
can be copied once, but that when the same code is used three times, it should
be extracted into a new procedure. The rule was introduced by Martin Fowler in
Refactoring and attributed to Don Roberts.
```

This provided us with the insight to know what aspects of our code can be
abstracted and which one cannot.

We decided at the end of the day that a monorepo would suit us best. So we spent
the better part of last week combining all of our services in to one repo, which
can be found [here](https://git.sr.ht/~erock/pico).

Moving to a monorepo allowed us to remove a lot of duplicated code which should
improve our velocity and hopefully when we make a change to one service, the
other services will enjoy the same updates.

It was a pretty satisfying feeling to remove a lot of code from our repo.

We also spent a good chunk of our effort refactoring our infrastructure to make
syncronizing deployments easier.

From merging all of our databases into one, to merging all of our code into one,
this is being done in preparation to build more services.

[We have a lot of ideas](https://todo.sr.ht/~erock/pico.sh?search=status%3Aopen%20label%3A%22service%22)
for services we want to build, and we keep thinking of more.

The next step for team pico is to prioritize the services we want to build and
then execute as quickly as possible. In essence, we are in discovery mode.

We want to hear from you, so let us know what services or features you think we
should work on next.

Join our [irc #pico.sh on libera](irc://irc.libera.chat/#pico.sh) or email us at
[hello@pico.sh](mailto:hello@pico.sh).

Be sure to subscribe to our [rss feed](https://hey.prose.sh/rss) to get the
latest updates at team pico.

That's it for now, thanks!
