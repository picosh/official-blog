---
title: rfc-5 link aggregator
description: What would an SSH link aggregation service look like?
date: 2024-01-20
tags: [rfc]
---

|                  |            |
| ---------------- | ---------- |
| **status**       | draft      |
| **last updated** | 2025-02-12 |

The link aggregator service has a rich history in the tech world. They are a great source for community building and for some of us, the primary place where we consume world news. When you want to read authentic experiences with products, services, tourism, restaurants, etc., how many of us add a "reddit" suffix to our searches in order to get the best results?

While we love the link aggregator services that exist today, there's a burning desire for us to improve it. In some ways, we feel like we can build something better, in other ways we want to build something we love to use.

The trick is how can we bring it into the pico platform and still make it usable.

Here's some business requirements:

- It must function as a tree of posts
- A post can be a community (e.g. subreddit), a link, a text post, or a reply to a post
- Ability to create communities
- Ability to submit posts to communities
- Ability to reply to posts
- Ability to upvote posts
- No ability to downvote posts
- Ability for users to moderate communities
- Authentication and authorization with SSH
- Entirely usable via SSH commands and a TUI
- A read-only web interface, publicly accessible
- It must be easy to host and minimal in implementation
- Receive notifications with RSS feeds

```bash
# submit a link to the service
echo "https://bower.sh" | ssh links.pico.sh r # alias for "reply"
# => https://links.pico.sh/ct7kAn

# reply to a post or comment
echo "what a great blog!" | ssh links.pico.sh r ct7kAn 

# vote on a post
ssh links.pico.sh v ct7kAn

# show a subtree of posts
ssh links.pico.sh s ct7kAn
 |1 erock ct7kAn
 |https://bower.sh

  |0 bob ab98Cz
  |what a great blog!
```

How does this differentiate from existing link aggregators? Well, this will not be widely accessible because users need to understand how to use SSH. This will add a barrier for mobile users to access this website.

> Our hypothesis is that mobile access to a link aggregator degrades discussion.

This will be an exclusive service for hackers: a clubhouse for us to relish in our own intrigue. Steeped in our exclusive discussion. What makes us excited about this idea is having a passwordless user experience, all relying on the familiar public-key cryptography. Even further this has really interesting implications: We don't need cookies or `Authorization` headers for authentication. No passwords, no cookies, no http headers, only a lone SSH command and a simple read-only web service.

We also think the simplicity of our implementation will allows us to focus more on content moderation and less on bug fixes. This will enable us to experiement with modern tech like leveraging AI tools to moderate and facilitate discussion.

If users really want to be able to submit posts in a web browser when we can use [web tunnels](https://pico.sh/tunnels).

# A note on decentralization

I'm sure some readers will be curious about creating a decentralized link aggregator service. While we are open to the idea of having a decentralized service, we do not like the complexity or hardware requirements necessary to support a decentralized system over something like ActivityPub. We want this to be simple to run and simple to use and from our experience with using services on ActivityPub, that's just not possible.
