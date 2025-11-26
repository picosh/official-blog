---
title: rfc-8 ping
description: An uptime monitor for services
date: 2025-11-26
tags: [rfc]
---

|                  |                 |
| ---------------- | --------------- |
| **status**       | draft           |
| **last updated** | 2025-11-26      |
| **site**         | https://pico.sh |

The primary use case for this service is to enable developers to easily monitor service uptime and cron services.

## An uptime monitor

```bash
curl -fsS https://pico.sh && ssh ping.pico.sh pico-uptime -t 1d
```

The name of the ping can be generated on-the-fly. The service requires authorization using an SSH key just like any other pico service.

The `-t` flag uses Go's [`time.ParseDuration`](https://pkg.go.dev/time#ParseDuration) and as long as we receive a single ping within the duration then the service is considered healthy.

## A cron monitor

```bash
0 0 * * * my_script.sh 2&>1 | ssh ping.pico.sh my_script -t 1d
```

You can also trigger a failure:

```bash
ssh ping.pico.sh boom -f
```

# notify

You can view the status of your pings using an SSH command

```bash
ssh ping.pico.sh status
```

We generate an RSS feed for this service that will send alerts when a ping has gone stale outside the time period provided.

```bash
ssh ping.pico.sh rss
```

# logs

You'll be able to see the logs piped into this service using an SSH command

```bash
ssh ping.pico.sh logs my_script
ssh ping.pico.sh logs my_script -f # follow
```
