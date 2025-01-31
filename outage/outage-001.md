---
title: outage-1 2023-06-02
description: What caused our recent outage?
date: 2023-06-03
tags: [outage]
---

Hey everyone.

It's been awhile since we've made an "official" post so I figured the recent
outage would be a good time to reach out.

> Service disruption happened from 2023-06-02 at 7:30 PM EDT to 2023-06-03 at
> 3:30 AM EDT. As a result, our services were unavailable for roughly 8 hours.

We currently use Oracle Cloud Infrastructure (OCI) for hosting all of the pico
services. Under-the-hood we use `docker-compose` to manage all of our running
services. These containers run on an `arm` VM which means we get to leverage
[Oracle's free tier](https://www.oracle.com/cloud/free/) to keep costs down.

In effect, the only thing we pay for are the domains.

There was an
[outage](https://ocistatus.oraclecloud.com/#/incidents/ocid1.oraclecloudincident.oc1.phx.amaaaaaavwew44aadod6jhd7jyvjnsiib3x2yppv4tf2qvjrlfdf32usdquq)
in the region we host pico (US East, Ashburn).

Reading the status page, it looks like the infrastructure was getting too hot
and causing a disruption to our services.

Even though the pico services are free, we take uptime seriously. Internally we
use pico services to host our own content so we have a stake in keeping them
online.

We have monitoring services setup to ensure that when there is an outage, we get
notified in our IRC channel.

We have no plans to move off of Oracle anytime soon, but we are open to
alternatives to ensure uptime meets our standards.

That's all, thanks for reading!
