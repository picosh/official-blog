---
title: rss-to-email using cron format
description: replacing digest_interval with cron
date: 2025-08-09
tags: [ann]
---

Last night we deployed a relatively significant change to our
[rss-to-email](https://pico.sh/feeds) service.

Previously, users could set a `digest_interval` where we would wait that amount
of time (e.g. 10 minutes, 6 hours, 1 day, etc.) before sending another email
digest.

This worked well initially, but users want to have more control when an email
digest would be sent. A common feature request: can I receive an email every
friday at 9am? Or: can I receive an email every day at 12pm?

So we are deprecating `digest_interval` in favor of a new property: `cron`,
which will allow users to set how often a digest email should be sent with finer
grained control over what time of day.

We are also rejecting any newly uploaded posts with `digest_interval`, you
**must** use the new `cron` format. Any file that is already in our system we
are automatically converting to the `cron` format.

You can read more about the `cron` format and its limitations here:
https://pico.sh/feeds#cron

Let us know what you think about this change!
