---
title: moving rss-to-email to pico+
date: 2026-01-08
tags: [ann]
---

Hello everyone,

We wanted to make an announcement about our [rss-to-email service](https://pico.sh/feeds).

We have been consistently hitting our email quota per month which prompted us at the pico headquarters to discuss our options. We are in the first week of our service month and already hit our quota. On one hand this is fantastic news: people are resonating with this service! However, this required us to bump up our payment plan. We don't take moving services behind a paywall lightly so we wanted to be thoughtful about this transition. We liked that this service has been free for years and enjoyed getting feedback from the community on how to make it better.

We added features to keep the number of emails to a minimum like having "keep alive" headers and an "unsubscribe" footer in our email digests.

We also recently refactored our service to use a [cron](/ann-032-rss-to-email-cron) format so users can have their email digests at a consistent time of day. It's a very useful service to us since the only way we can notify users is through rss. It is part of our design ethos to use a pull form of communication and let users subscribe using their own workflow. We see our platform as enabling developers while getting out of the way.

There are two primary reasons why we charge for some our services:

- To prevent abuse
- To provide resources that have real costs

We want this to be a sustainable platform. We want our services to scale with the user base.

These decisions aren't easy but we decided to make our rss-to-email service part of the [pico+](https://pico.sh/plus) package.

Here's the deprecation plan. If you are a pico+ user, you will see no difference in the service, thank you for your continued support! If you are on the free plan of pico, we will be sending a header in your email digests linking to this post.

> On **2026-01-22** we will cut off the service to all free pico users.

We think a two week notice is resonable and it gives us time to evaluate usage numbers before the next service month.

I think that's it, thanks for reading!
