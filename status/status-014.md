---
title: status-14 - a new year
date: 2026-01-04
tags: [status]
---

Greetings travelers, I hope this post reaches you in good health and high spirits for what's to come in 2026.

I wanted to take this new year as an opportunity to talk about pico: where we are and where we want to be.

# where we are

Earlier this year we've seen a large influx of new users from hitting the front page of various tech sites. This prompted us to **refactor** some of our services in order to better serve our new patrons. This primarily meant we replaced `minio` with a custom filesystem adapter for our object storage system. This resulted in much better service reliability -- not to mention performance -- and we haven't experienced any issues since we made the transition. During that migration we also did not receive a single bug request related to the migration. Nice.

On a personal note, during that same time I (Eric) had my second baby, which caused me to shift my priorities to family life for most of the year. You can read about my [personal journey on my blog](https://bower.sh/status-001). This can be seen as a sharp decline in feature development and commit history. As of the last month or so I finally have time to focus more on pico development with a renewed vigor in pushing the platform even further in 2026.

Here's a shortlist of what we accomplished this year:

- [tuns: enabled site analytics](/ann-025-tuns-site-analytics)
- [we shut down our docker image registry service](/ann-027-shutting-down-docker-image-registry-service)
- [pages http caching](/ann-026-pages-http-caching)
- [added an EU node for pages and tuns](/ann-029-pico-services-global)
- [added `rsync --delete` support to all services](/ann-031-rsync-with-delete)
- [rss-to-email now uses `cron` format for email digests](/ann-032-rss-to-email-cron)
- [added ssh certificates for finer-grained access control](https://pico.sh/access-control)
- [had an existential crises about prose.sh and pastes.sh](/rfc-009-shutdown-prose-and-pastes)
- [continued development on `git-pr`: our patchbin service](https://pr.pico.sh)

Finally, I want to mention, that our user-base is growing. We have more people using our platform than ever and we see that trend increasing in 2026.

# where we want to be

We have things we can talk about and things we cannot talk about for 2026.

To start, we have a [proof-of-concept](https://github.com/picosh/pico/pull/202) for our [ping rfc-008](/rfc-008-ping) which we are calling **pipe monitors**. We are building this for multiple reasons. Selfishly, we need better monitoring on our internal pipes that we use as the pubsub backbone for all of our services. Additionally, we see this as a way for users to also monitor their own services. Whether it is deployed in the cloud, self-hosted services, or crons, pipe monitors can track their uptime. This is exactly what we are looking for when creating new functionality and we are excited about its release.

We used to have a [list service](/ann-012-lists-shutdown-notice) that eventually turned into [prose.sh](https://prose.sh). It used our homegrown [plain text list spec](https://pico.sh/plain-text-lists). Well, we miss it, and are considering folding that functionality into prose. You can track that work here: https://pr.pico.sh/prs/102

We are also going to continue our development on what I'm calling "the disappearing code-forge." It's going to involve [pgit](https://pgit.pico.sh) -- our static site generator for git repos -- and [git-pr](https://pr.pico.sh) -- our git collaboration service. Code forge's are all falling into the same trap: building central, social networks for code collaboration. These code forges all share the underlying assumptions: a central, social, network of git repos. Even the "decentralized" code forges are creating walled gardens. Our mission here is to democratize collaboration with simple, maintainable, self-hosted services. More to come later this year.

Finally, in terms of global hosting infrastructure, we have some fun news about that. To start, we fully intend to add [prose.sh](https://prose.sh) and [pico.sh](https://pico.sh) to our global services. Additionally, we are evaluating other international locations, with our eye somewhere in the Singapore region. More details to come, but we are excited about increasing our global reach in 2026.

All of our services primarily live in Ashburn, VA, on Oracle's Cloud, but that might change this year. We have access to a colocation in Michigan, and along with it, a quarter rack of compute Antonio procured last year. We are going to experiment moving some of our services to it later this year. Do we need to move off of OCI? No, but we enjoy self-hosting and love the idea of having our services off of "hyper-scalers." Obviously there's a limit, but we are excited about hacking on it, and we think users will enjoy faster load times, especially for our compute heavy services.

With this new hardware, we also plan on experimenting with offering compute to users. This would allow them to host their own services on our infra. We are still playing around with some ideas, but keep an eye out for new RFCs later this year.

I think that's it, we are excited to be with you all in the 2026, and thank you for your time.
