---
title: TUI deprecations
description: We are consolidating our TUI apps across pico
date: 2024-04-08
tags: [announcement, deprecate]
---

tl;dr There is only one way to access our SSH TUI:

```bash
ssh pico.sh
```

Greetings!

Currently, every service accesses the same TUI: it doesn't matter if you are
SSHing into `pico.sh`, `prose.sh`, `feeds.sh`, `pastes.sh` etc. they all have a
similar but slightly different TUI.

Originally, we envisioned all of our services to be completely separate. Well,
over the course of the year we have been slowly trying to centralize common
resources across our services. We are doing this because maintaining N number of
databases, TUIs, and docs has been quite the burden for us.

We don't want pico to feel like a chore for us or our users. This transition all
started when we decided to merge all our service databases into one. Since then,
we have stripped the landing pages for all sites to their essentials while
pushing everyone to our centralized docs. Most of the sites hosted duplicated
pages and information that we would have to update N times whenever we made a
change.

As a result, we are killing the TUIs for all services -- except for `pico.sh`.
So, if you used to `ssh prose.sh` or `ssh feeds.sh` you now need to:

```bash
ssh pico.sh
```

That's the main meaningful change at this point in time.

However, it has been no surprise to some of you that we have been continuing to
experiment with new UIs. We recently started beta testing a
[web UI](https://pico.sh/ui#web-ui) leveraging web tunnels. If you haven't tried
it out we highly recommend it.

Well, all of this is to say that we are going to re-focus our efforts on the TUI
and try to strike a good balance between our various UIs, CLIs, etc. In order to
service TUI improvements, we have to refactor how it works, and with that comes
this deprecation notice.

We will be deploying this change within a day or so. The only feature we are
killing is the ability to delete prose posts within the TUI. Don't worry, we
will eventually bring something like it back. In the meantime, we recommend
deleting prose posts by using `sftp`:

```
sftp prose.sh
> rm hello-world.md
```

That's all for now. I do plan on writing another post about our approach to
building user interfaces shortly, so be sure to subscribe to our RSS feed!
[And use feeds.sh!](https://pico.sh/feeds)
