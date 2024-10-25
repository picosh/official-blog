---
title: rfc 0004 link aggregator
description: What would an SSH link aggregation service look like?
date: 2024-01-20
tags: [rfc]
---

We want to create a link aggregator service that can only be accessible via SSH.
Think hacker news but authentication and authorization happens via SSH.

The trick is making it usable.

Here's how we imagine it could work:

- User initiates an SSH tunnel to links.sh (imaginary name)
- links.sh launches a dedicated web server for that user
- This allows the user to access links.sh from localhost
- We automatically authenticate and authorize the user accessing links.sh
- User can read, comment, and post articles in their browser

We would also create an SSH app to allow the user to easily submit links without
having to setup an SSH tunnel

```bash
ssh links.sh post https://bower.sh/front-end-complexity
```

How does this differentiate from existing link aggregators? Well, this will not
be widely accessible because users need to understand how to use SSH. This will
add a barrier for mobile users to access this website. In fact, we will not
build a mobile friendly version of the website at all.

> Our hypothesis is that mobile access to a link aggregator degrades discussion.

This will be an exclusive service for hackers: a clubhouse for us to relish in
our own intrigue. Steeped in our exclusive discussion. What makes us excited
about this idea is having a passwordless user experience, all relying on the
familiar public-key cryptography. Even further this has really interesting
implications: We don't need cookies or `Authorization` headers for
authentication. No passwords, no cookies, no http headers, only a lone SSH
command.
