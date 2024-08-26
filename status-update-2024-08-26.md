---
title: Status update - Aug 2024
description: pico.sh platform update
tags: [status]
---

Greetings!

It's been awhile since we've made a status update even though a lot has been
happening at pico headquarters.

# tuns

We are seeing a lot of activity around our tunnel service,
[tuns.sh](https://pico.sh/tuns).

This feels like a strong signal that we are offering something that is
relatively unique. We plan on increasing feature development on tuns to see
where if we can get wider adoption. This also includes better documentation and
posts around using tuns to its full advantage.

## namespaced subdomains

In order to prevent users from colliding against similar subdomains (e.g. two
users with a `dev` namespace) we decided to prefix all namespaces with the their
pico username. So when you initiate a tunnel to tuns, we will create a
subdomain: `https://{username}-{namespace}.tuns.sh`.

# pgs default headers

We have gone back and forth on providing sane defaults for sites deployed on
[pgs.sh](https://pico.sh/pgs).

We decided that our default CSP header was too strict and decided to remove it
completely.

Further, the user can override most default headers that we apply automatically
for every pages site.

We hope with these changes it'll be easier than ever to deploy sites on pages
without immediately needing to setup a custom domain.

# sync pubkeys

We quietly made it possible to sync an `authorized_keys` file to pico.sh for
account authorization. This feature makes it possible to fetch and upload an
authorized keys file.

```bash
# download current keys
rsync pico.sh:/authorized_keys .
# add, remove, edit comments
# now upload!
rsync authorized_keys pico.sh:/authorized_keys
```

This will sync keys so you don't have to go into our TUI to manage authorization
of your pico account.

> Caveat: As a safety feature we **never** remove the pubkey for the current
> authenticated SSH session.

# multi-region?

We aren't making promises, but we are investigating having **pages** and
**tuns** be multi-region, including Europe. We don't want to talk too much about
it but we are figuring out what we need to do and how much it will cost. We see
this as a necessary next step for us and we are excited to see how it improves
adoption.

# end

Thanks for reading!
