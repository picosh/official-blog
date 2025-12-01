---
title: status-11
date: 2024-12-16
tags: [status]
---

Happy holidays!

A lot has happened this year at pico headquarters so I wanted to give a year-end review.

Some quick stats:

- 362 pages sites
- 100 pico+ subscriptions
- 72 tuns sites
- ~50 monthly active prose posts
- ~20 monthly active pages sites
- ~10 monthly active tuns sites

> monthly active **X** = created or updated by month

Overall we are seeing usage increase across all services, which is both humbling and exciting for us!

Antonio and I (Eric) have been having a lot of fun working on pico. Every single day we are touching the pico platform, trying to figure out ways to make it better.

As we reflect on 2024, we wanted to share some of our own internal thoughts about the platform and where we want to take it into 2025 and beyond.

We recently created a new tagline for pico:

> services that empower developers using `ssh`.

We think this strikes a nice balance between what we are today and where we want to go into the future. Our focus is squarely on individual developers and providing tools that make their lives easier and more enjoyable.

Here's a high-level summary of what we have done in 2024:

- Massive improvements to [pgs](https://pgs.sh)
  - [redirects and rewrites](https://pico.sh/pgs#custom-redirects-and-rewrites)
  - [proxying](https://pico.sh/pgs#proxy-to-another-service)
  - [http caching](https://blog.pico.sh/ann-026-pages-http-caching)
  - Removed default content-security policy so it's easier for users to publish sites and have them "just work"
- Massive improvements to [tuns](https://tuns.sh)
  - [site usage analytics](https://blog.pico.sh/ann-025-tuns-site-analytics)
  - [tunmgr](https://pico.sh/tuns#tunmgr)
  - [user namespace](https://pico.sh/tuns#user-namespace)
  - [udp tunneling](https://pico.sh/tuns#udp-tunneling)
- Introduced [pipe](https://pipe.pico.sh)
  - Authenticated, networked `*nix` pipes
- Introduced [git-pr](https://pr.pico.sh)
  - The simplest git collaboration tool
- Moderate changes to [prose](https://prose.sh) and [pastes](https://pastes.sh)
  - [new design](https://bower.sh)
- Moderate changes to [rss-to-email](https://pico.sh/feeds)
  - keep-alive timers
  - email errors to users
- Created a log drain for all users
  - pico TUI -> Logs
- Created a new UI for site usage analytics
  - pico TUI -> Analytics
- Shutdown lists.sh
- Shutdown imgs.sh
- Shutdown our experimental web UI

Whew, that's a lot.

Beyond making our services the best they can be and experimenting with new ideas, we have been actively working on `pico-global`. This would deploy VMs in multiple regions across the planet. Our goal here is to provide low latency services regardless of where users live. We are trying to do it in a way that is sustainable for us so we are taking our time on its development. We fully intend to get `pico-global` released and generally available in Q1 2025.

Further, we want to build services that haven't been created before. We want to build something that is so unique developers **have** to use our platform. This is easier said than done. The market is saturated. We have to be creative. To be blunt, **what we have today is not good enough**. With [radical experimentation](https://blog.pico.sh/rfc-001-radical-experimentation) comes tough decisions. Not all of the services we have today will likely survive 2025. By the end of next year, we will likely be a radically different platform.

Thanks for taking the time to read this post, we greatly appreciate all the enthusiasm users have shown us throughout 2024. We are excited to continue to grow into the new year.

Thanks and happy holidays!
