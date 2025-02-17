---
title: rss-to-email remote cli
description: with the ability to run a feed digest post
date: 2025-02-06
tags: [ann]
---

At pico we need the ability to notify users of announcements, deprecations,
status updates, outages, and pico+ membership updates. We decided at the
beginning that we wanted to lean on a standardized communication platform like
RSS and email. As a result, [rss-to-email](https://pico.sh/feeds) is a service
that is foundational to pico which allows anyone to subscribe to RSS feeds and
receive digest emails when there are updates to their RSS feeds.

Users have been enjoying the simplicity and ergonomics around `rss-to-email` for
years now with great success. However, one of the challenges is empowering users
to debug their feed digests when they aren't receiving updates that they should.
This is in large part because our service relies on a cron timer without the
ability to run the cron manually to make sure it works. I'm sure there are many
readers nodding their heads at this classic problem with cron.

So we decided to deploy a remote CLI for `rss-to-email` that allows users to run
their feed digest posts as a one-off command. We see this as a huge UX
improvement because now users can see exactly why their feed digest post does or
does not send an email.

Using the remote CLI is simple:

```bash
ssh feeds.pico.sh run {filename}
```

This will output all of the logs we use internally to debug `rss-to-email`.

We also quickly added a couple other commands to improve the UX of the service:

```bash
ssh feeds.pico.sh ls # print feed digest posts with metadata
ssh feeds.pico.sh rm {filename} # remove a feed digest post
```

If you have any comments, feedback or other commands we should add to the remote
CLI, please let us know!

Thanks!
