---
title: Same pubkeys, multiple accounts
description: We are deprecating duplicate public keys
date: 2024-02-23
tags: [announcement, deprecate]
---

Greetings!

We are deprecating the ability to have the same public key used for multiple
pico accounts.

> If you currently have the same public key for multiple accounts, we **highly
> recommend de-duplicating them**

# why?

This feature has caused users issues in the past. For example, it is very easy
to accidentally login with the wrong user even though you specified the user
when connecting to us -- because we might disregard the username.

Further, we are planning a bunch of new features that require us to use the
username field when connecting to us for advanced features. So, in order for us
to make these new features work properly, users cannot have the same public key
for multiple accounts.

# what should I do?

First, you will still be able to use duplicated pubkeys, just like you
previously were able to do. We are not killing that logic at this point in time.
So user operations will continue to function normally. The only code change we
made was to prevent future duplicate public keys from being added.

Again, if you don't remove duplicate keys, future features will be unavailable
to you.

If you are using the same public key for multiple accounts, create a separate
key for those accounts and then delete the public key on those accounts.

If you need any assistance please do not hesitate to email us or join IRC.
