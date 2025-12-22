---
title: rfc-9 should we shutdown prose.sh and pastes.sh?
description: Replace them with pgs.sh
date: 2025-12-15
tags: [rfc]
---

|            |                 |
| ---------- | --------------- |
| **status** | rejected        |
| **site**   | https://pico.sh |

> This RFC has been **rejected!** Talking with the community we see there is still value in having an easy to to upload markdown files for a blog. As a result we will **not** be shutting down these services and will be creating additional rfcs to enhance these services.

As we prepare for the new year, we have a set of new services we plan on building. We are halfway through development of [rfc-007 access-control](/rfc-007-access-control) and are about to begin development on [rfc-008 ping](/rfc-008-ping). We also have features we want to develop inside of [pgs.sh](https://pgs.sh) and [pipe.pico.sh](https://pipe.pico.sh).

As a result, we are evaluating our other services and how they fit into the ethos of pico. There are two services in particular that we are starting to feel don't quite fit: prose.sh and pastes.sh. These are some of the first services we built three years ago and while we still use them, they kind of clash with pgs. While the maintenance is low for these projects, they still require:

- Domain names
- Dedicated IPv4/6 addresses
- Lives in our monorepo
- Have feature requests and bug fixes

Now we know a bunch of people are using these services every month and it's a great way for people to see how our services work, but ultimately we are faced with a dilemma: continue to accrue debt from these services and navigate through codebase, infrastructure in order to support them or kill them and bum people out.

Now if we did shutdown these services, we have support a smooth transition for users:

- A modest deprecation timeline (4-6 weeks)
- [A Hugo template with prose's theme](https://github.com/picosh/prose-hugo)
- A special pgs project (`tmp`) that automatically removes files after 1-week (replicating the core of pastes)

Our decision is **not yet final** which is why we are writing this RFC. We will be collecting feedback over the next week or so and make a decision then.

Thanks for taking the time to read and engage with pico! We will be releasing more RFCs this year so stay tuned and subscribe to our RSS feed!
