---
title: status-1
date: 2022-03-15
tags: [status]
---

Hey!

I wanted to give a more general status update to pico services. Here's a brief list of things we've worked on recently

- [imgs.sh](https://imgs.sh): New image hosting service
- [feeds.sh](https://feeds.sh): An RSS feed to email notification service
- [aliases](https://prose.sh/help#blog-readme) are now supported for [prose.sh](https://prose.sh)
- Support for custom [favicon](https://prose.sh/help#blog-readme) for [prose.sh](https://prose.sh)
- Ability to see view count in the CMS for any pico service
- Design tweaks to [prose.sh](https://prose.sh)
- Added RSS alternative link to blog pages
- [draft](https://prose.sh/help#hugo-support) variable will hide the post from blog page for [prose.sh](https://prose.sh)

# [lists.sh](https://lists.sh)

I also wanted to touch on something else we've been thinking about lately. Clearly prose.sh has been getting a lot of love from us. Most of our development is designed to make prose a better service. We've been migrating as much of this work onto [lists.sh](https://lists.sh) and the other services where it makes sense.

However, we are in general seeing less engagement on lists.sh. This has been weighing heavily on our minds and we are considering the following options:

- Continue to maintain it (it's not much work)
- Merge it into prose (ability to upload list files onto prose and rendering them there)
- Discontinue service

We've love to read anyone's thoughts on the long-term plan for lists.

# paas

We are also seriously considering building a platform-as-a-service under the pico service umbrella. This is still very much in its infancy but we have a project[^1] that antontio created a few years ago that we are thinking about productizing.

The general idea is to allow users to deploy their apps using docker compose. It would be for solo and just-let-me-deploy projects. All the user would need is to have a git project with a docker compose file and then `git push` to our remote git server and we would handle the rest of the infrastructure and maintenance.

If you are interested in this idea please write to us!

# our commitment

I wanted to also reinforce that we plan on maintaining these services for the long-term. Costs are extremely low for us ($210 / year) as well as maintenance.

We also recently installed better alerting which get sent to our IRC channel. What this means is are on top of keeping these services running as long as possible.

That's it for now, thanks!

[^1]: https://github.com/antoniomika/pcompose
