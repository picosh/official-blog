---
title: rfc-8 pipe monitors
description: An uptime monitor for services
date: 2025-11-26
tags: [rfc]
---

|            |                 |
| ---------- | --------------- |
| **status** | draft           |
| **site**   | https://pico.sh |

The primary use case for this service is to enable developers to easily monitor service uptime and cron services leveraging pipes. It will also enable developers to monitor their pipes' health when using it as their pubsub system. This will be an enhancement built on top of https://pipe.pico.sh. The pipe service requires authorization using an SSH key just like any other pico service.

To be clear, we do not run any of these commands, the end user is responsible for having a compute system to run these commands for uptime monitoring. We merely track the status of your pipe topics.

## create the monitor

First, create the topic with the monitor duration:

```bash
ssh pipe.pico.sh monitor pico-uptime 1d
```

The duration parameter uses Go's [`time.ParseDuration`](https://pkg.go.dev/time#ParseDuration) and as long as we receive a single ping within the duration then the service is considered healthy.

## an uptime monitor

An uptime monitor tracks the status of your website by sending a ping to our pipe service on an interval.

If you have a system that runs cron, you could create an entry that runs everyday that checks your website can be fetched successfully using `curl`.

```bash
0 0 * * * curl -fsS https://pico.sh && ssh pipe.pico.sh pub pico-uptime
```

## a cron monitor

Similarly, the same system -- with a slightly different configuration -- could be used to track the status of your cron jobs.

```bash
ssh pipe.pico.sh monitor my_script 1d
```

```bash
0 0 * * * my_script.sh && ssh pipe.pico.sh pub my_script
```

Again, this would run your cron daily and send a ping to us to make sure it succeeded.

## notify

You can view the status of your pipe topics using an SSH command

```bash
ssh pipe.pico.sh status
```

This will print a list of your monitored pipe topics and if they are in a healthy state.

We also generate an RSS feed for this service that will send alerts when a topic has gone stale outside the time period provided.

```bash
ssh pipe.pico.sh rss
```

We also have an http rss feed:

```
https://pipe.pico.sh/rss/<token>
```

## update monitor

Just run the same monitor command used to create (it's an upsert):

```bash
ssh pipe.pico.sh monitor pico-uptime 6h
```

Or you can delete it completely:

```bash
ssh pipe.pico.sh monitor pico-uptime -d
```
