---
title: pico+ now accepts global payments
description: We updated pico+ to accept from payments around the world
date: 2024-05-14
tags: [announcement, feature]
---

Hey everyone!

We are excited to announce that we have switched payment processors and can now
accept payments outside of North America.

This has been a work in progress ever since we launched `pico+`. Because of the
legal restrictions to sell software services internationally, it was prohibitive
for us to sell to pico users outside of US and Canada.

In particular, if we want to sell `pico+` to users in the EU, Mexico, and
elsewhere, we would need to create a tax registration for each country. As we
spent time investigating VAT, One-Stop-Shop, and the different tax regulations
country-to-country ... we quickly came to the realization that this is not
something we want to spend time on. We want to spend our time on building
amazing products and services.

Upon reflection, this is one area where joining a donations platform could have
been a little easier on us. Ultimately we want to provide web services which
feels more conducive to a typical monthly model, but it definitely made us think
twice about our decision.

So we discovered that we can leverage a
[Merchant of Record](https://stripe.com/resources/more/merchant-of-record) who
will shoulder the tax burden for us.

We originally investigated MoRs a few months ago by signing up with
[paddle](https://paddle.com). However, they rejected our application without
being able to tell us why.

Thankfully, when we applied to [lemonsqueezy](https://www.lemonsqueezy.com/)
last week -- another MoR -- and they accepted our application. Within a day we
were able to switch from Stripe to them, success!

Thank you to everyone who messaged us about adding support for other countries,
it motivated us to find a solution.

# So what's next?

We don't want to provide a subpar service for any pico user. Currently, all of
our services live inside Ashburn Virginia. We aren't committing to anything yet,
but we are investigating how feasible it would be to make pico services
multi-region. If our services feel slow to you, let us know, it helps us
prioritize our work.

That's it for now, thanks!
