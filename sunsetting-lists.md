---
title: Sunsetting lists.sh
description: first in, first out
date: 2023-10-15
---

Hey everyone!

We've been monitoring our services over the months and we are beginning to think
about which services are performing well and which ones aren't.

Since we initially
[launched **lists.sh**](https://news.ycombinator.com/item?id=31154567) on
**2022-04-27** we've been escatic with the reception. Initially there was a ton
of interest in the service and activity with it.

Then we released [prose.sh](https://prose.sh) and saw a similar surge in
activity. As we think about the type of services we want to support, we feel
like there is just too much overlap between lists.sh and prose.sh to keep them
both.

We had a grand vision by leveraging the spec we built and ideally targetting
clients other than the browser. We quickly launched a gemini client for
lists.sh, hoping to engage with that community.

Overall we've continued to see the activity of lists.sh decline. Further, we see
posts on prose.sh that are almost exclusively lists. This reinforces our stance
that there's too much overlap between lists and prose, to the point where they
are competing with each other.

We want to build services that we actually use. No one on the pico team has
touched lists.sh in months. We haven't spent any time on service maintenance,
feature development, or even posting content ourselves.

# Shutdown Roadmap

> New posts in the last month: 0

So we are sad to say but this is the official deprecation notice for lists.sh.

Here's the roadmap:

## 2023-10-15

- Publish this blog post
- Make changes to the website to inform users of the deprecation
- Spin down the SSH server so no one can publish anymore

## 2024-01-01

- Spin down the web server
- Remove all code related to lists.sh inside
  [pico](https://github.com/picosh/pico)
- Extract list parser so anyone can run it themselves

## 2024-03-13

- Let the lists.sh domain expire

# We are here to stay

This doesn't mean anything for the other services we provide. In fact, another
big reason why we are killing lists.sh is so we can focus on new ideas while
also focusing on the ones that are continuing to be successful.

Thanks for your continued support and be sure to subscribe to our RSS feed
because we have a lot of new ideas percolating behind-the-scenes that we think
is going to transform pico for the better.
