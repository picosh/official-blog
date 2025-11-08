---
title: tuns.sh site analytics
description: get usage analytics for any tuns site
date: 2024-12-16
tags: [ann]
---

We recently enabled the ability for automatic site usage analytics[^1] for tuns
sites. With site usage analytics, we provide webmasters with the ability to see
unique visitors, referers, top urls, and top 404 urls. It leverages the same
analytics system we have for pages[^2] and prose[^3].

In order to see site usage analytics for tuns sites, you must have analytics
enabled. Enabling analytics is easy, simply log into our pico TUI:

```bash
ssh pico.sh
# -> Settings
# [tab] to Analytics enable/disable button
# [enter]
# voila!
```

Then after users have navigated to your tuns site, you can view the analytics
from our TUI:

```bash
ssh pico.sh
# -> Analytics

# [type] in input box: `stats`
# (analytics output)...

# [type] in input box: `site erock-site.tuns.sh`
# (analytics output)...
```

# impl

I wanted to touch briefly on our implementation since it relates to another pico
server, pipe[^4], which is our authenticated, networked `*nix` pipes service.

We created a pipe topic `metric-drain` where we send all site usage analytics
info from our services (prose, pgs, and tuns). Then we have a function that
subscribes to the `metric-drain` and adds the info to our analytics database.

There are plenty of other services that could enable us to have a distributed
system for metrics aggregation, but pipe was surprisingly pleasant for this
particular use case.

What's really nice is our observability over the metric drain. We now have a
single channel where we can view all metrics being sent through our
`metric-drain`:

```bash
ssh pipe.pico.sh sub metric-drain
```

During development, it was very easy for us to test this system because we can
just submit metrics through our topic:

```bash
echo '{"host":"pico.sh", "path":"/tuns"}' | ssh pipe.pico.sh pub metric-drain
```

That's it!

[^1]: https://pico.sh/analytics
[^2]: https://pgs.sh
[^3]: https://prose.sh
[^4]: https://pipe.pico.sh
