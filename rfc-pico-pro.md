---
date: 2022-12-31
title: RFC pico pro
description: A proposal for supporting pico services
draft: true
---

We are building a few services that would be expensive to maintain over time
without requiring financial support. Instead of asking users to pay for each
service individually, we'd rather bundle them all into a single umbrella, **pico
pro**.

Pico pro would be a subscription service, but I don't want to manage
subscriptions. Instead I think what we should do is require a year subscription
but the user would have to manually review every year. We would send an email
notification prior to the subscription ending to ask users to renew.

I also want to employ the sourcehut payment plan where each "tier" offers the
same level of features but we allow users to contribute more if they want.

## Pricing

- $20/yr
- $50/yr
- $100/yr

Requiring a year subscription has a few benefits:

- We can fund the entire year for the user upfront
- Fewer options to decide
- We don't need to worry about storing or keeping CC info since it's a one time
  payment every year

## Payment services

The obvious choice is Stripe. But we could investigate other options if Stripe
is too restrictive or expensive.

## Technical details

It would be great if we could figure out a way to have users submit their
payment within our CMS. If not then we'll need to send users to a
javascript-enabled site.

I think inside the CMS we should have CTAs that nudge users to pico pro. We
would have a sub-app dedicated to describing pico pro and why to upgrade. If a
user does upgrade they should probably see a fancy banner that indicates they
are pro members. I think adding a "support" section could be interesting that
opens an IRC client to a private channel for pico pro users. This would be a
great way to get immediate support from us.

Right now when you log into the CMS you see the following sections:

```
Set username
Manage posts
Manage keys
Exit
```

For non-pro members they would see:

```diff
Set username
Manage posts
Manage keys
+ Pro
Exit
```

For pro members they would see:

```diff
Set username
Manage posts
Manage keys
+ Pro
+ Support
Exit
```

## What services require payment?

Anything that requires extra resources to fund that increases price based on
usage. For example, our image hosting service is going to be expensive to
maintain so we want to charge. Basically if it costs us extra time or resources
to maintain the service then we want to charge for it.

## Open source contributions

We want to take a portion of the proceeds to donate to open source projects we
are using. We use lets encrypt so that would be an obvious choice.

I think we should try to contribute 25% of profits to open source. We can play
around with the percentage.
