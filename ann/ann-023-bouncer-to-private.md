---
title: we are making our bouncer private
description: A complimentary service for pico+ users
date: 2024-11-07
tags: [ann]
---

We've been hosting a public [soju](https://soju.im) instance for the better part of a year now. It has always been our desire to get more people in our IRC channel to enable collaboration which is why we made it publicly available.

In the last 60 days, we managed to have 99% uptime and when we did go offline it was to upgrade `soju`.

However, while it has been a lot of fun to hack on, the upstream project `soju` has a bunch of active development -- which is awesome! -- but with it comes regressions and breaking changes. It is not uncommon for us to have to fix our deployment in order for us to apply upstream changes.

Finally, this is not our core service, it is designed to be complimentary. As a result, we plan to transition our bouncer from public to **private**. Only `pico+` users will have access to our bouncer.

We plan to keep our bouncer running for as long as we are still using IRC for our realtime comms.

> Bouncer will become private on 2024/11/15

# What does this mean for current bouncer users?

We are going to make it so when you authenticate to our bouncer we will require an active [pico+](https://pico.sh/plus) membership. That means any non-pico+ user on our bouncer will not be not be able to re-authenticate after the transition.

Feel free to chat with us on `#pico.sh` if you have strong feelings about this transition, positive of otherwise.
