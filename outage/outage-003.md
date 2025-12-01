---
title: outage-3 2025-08-18
description: pgs outage post-mortem
date: 2025-08-18
tags: [outage]
---

Between 4am-7am EST we had an outage for the following services:

- `pgs.sh`
- `pico.sh` tui
- `pipe.pico.sh`

We are still investigating what happened but it looks like `pgs` was oomkilled because of a memory leak.

We apologize for any inconvenience this might have caused and we are continuing our root cause analysis to prevent this from happening again.

Thanks!
