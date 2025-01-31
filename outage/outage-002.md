---
title: outage-2 2024-05-27
description: tuns, bouncer, feeds, and docker registry outage post-mortem
date: 2024-05-28
tags: [outage]
---

Hey all,

We had a recent service outage and figured we should write a post-mortem of what
happened and how we are going to prevent it from happening again.

On `2024-05-27` at `12:19 PM EST` we became aware that our bouncer went offline.
We quickly started investigating the cause and came up with a plan to get our
services back online. Upon initial investigation our VM was unresposive and our
immediate remediation was to force reboot it. This resolved the outage and got
our services back online.

The following services were impacted:

- [tuns](https://pico.sh/tuns)
- [bouncer](https://pico.sh/irc)
- [feeds](https://pico.sh/feeds)
- [docker registry](https://pico.sh/imgs)

Outage duration:

- Offline: `2024-05-27` at `11:02 AM EST`
- Online: `2024-05-27` at `12:58 PM EST`
- Total duration: 1 hour and 56 minutes

Once services were back online we started investigating the root cause. After
looking at our resource monitoring and logs we discovered an underlying issue
with `tuns` (our instance of `sish`).

# Root Cause

The root cause was our VM ran out of memory, here's the summary:

- We provide a `tuns` console so user's can view requests that are made to their
  tunnels (request inspection)
- That service requires request and response payloads to be loaded into memory
- Usage of `tuns` spiked yesterday and caused our VM to run out of memory
- VM became unresponsive

# Prevention

`sish` has a setting `--service-console-max-content-length` that let's us decide
when to show the request/response payload to a user (reading it into memory). We
are setting this to something within the confines of our VM's memory limits. We
then stress tested this change to confirm it will prevent the root cause from
happening again.

# Monitoring

We have an IRC channel (`#pico.sh-ops`) to receive alerts from our monitoring
systems. We use prometheus for all of our services and we **did** receive alerts
about the service outage. Unfortunately for us, we did not get pinged on our
phones because we were no longer connected to IRC (through our bouncer).

We already have a bot that connects to our bouncer in order to send us emails
for important messages, so we are going to extend this bot to send email alerts
when it cannot connect successfully to our bouncer.

# Conclusion

We take service availability and uptime seriously and thank everyone for their
patience.
