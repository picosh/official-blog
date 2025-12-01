---
title: status-13
date: 2025-08-02
tags: [status]
---

Wow, it's been 4 months since our [last update](/status-012), time flies.

We have been mostly idling since we got a big influx of new users earlier this year.

We have primarily been focused on service uptime and refactoring how some of our services work in order to handle the uptick in usage.

In particular, we switched from using `minio` to our own custom built `fs` storage adapter. This resulted in a dramatic increase in service reliability. It also made it easier for us to develop against our services since we don't have a hard dependency on `minio`. This is not because `minio` is necessarily ineffecient, rather, it is designed for distributed object storage and that's a feature we don't really need at this point. That's not to say we won't ever need to move back to a distributed object storage service in the future and we made sure that our `fs` adapter was fully compatible if we ever do need to switch again. But overall we don't have to touch our prod services as much and object response times have improved. Success!

Now that we don't rely on `minio` for object storage, we also decided to spend some time making it easier to self-host `pgs.sh`. It's still a work-in-progress but we are at the point where anyone can quickly get `pgs` running themselves with 95% of the same feature-set (we don't have a great way to enable site analytics). If you are interested in self-hosting `pgs` you can find our guide here: https://github.com/picosh/pgs

Let us know if you run into any issues!

We have been slowly chatting about what we want to work on next. When thinking about our design principles inside of [rfc-001](/rfc-001-radical-experimentation) and what we could build next, we keep coming back to building a compute service. We are reluctant to enter this PaaS space because it is over-crowded and a race-to-the-bottom in terms of pricing. We already have a working prototype, codenamed `picolo`: a small instrument for deploying containers. We will post an [rfc](/?tag=rfc) as we iron out the features.

Finally, we are working on a new authentication/authorization mechanism for `pico` that would enable teams to work on our platform: [rfc-007](/rfc-007-access-control). Let us know what you think!

I think that covers most of what we have been working on lately. Cya!
