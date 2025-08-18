---
title: rfc-7 access control
description: Controlling access to your pico account with SSH certificates
date: 2025-08-03
tags: [rfc]
aliases:
  - /rfc-007-teams
---

|                  |                 |
| ---------------- | --------------- |
| **status**       | draft           |
| **last updated** | 2025-04-27      |
| **site**         | https://pico.sh |

# Access control

If we want to be able to facilitate teams then we need a way for administrators
to control access. We also need a way to audit access.

We accomplish access control using
[SSH certificates](https://goteleport.com/blog/how-to-configure-ssh-certificate-based-authentication/).
In particular, there's a `principals` field that we can leverage for role-based
access. When an admin generates a key for a teammate, a limited-access machine,
or a robot user, they can specify which services they have access to within the
`principals` field.

The certificate authority that will generate ssh keys will be created
automatically. We could allow users to upload their own CA but this feels like a
quality-of-life improvement. We allow the user to export their keys whenever
they want.

Workflow:

- Admin signs up for the "pro" plan
- Admin runs `ssh pico.sh keygen -i bob -n tuns.sh,pgs.sh -V +52w` to generate a
  key on behalf of a user
- Admin shares key with user
- User has access to pico services

if a user has `pico.sh` in their `principals` then they have access to the TUI,
but not the ability to generate keys or modify public keys.

Only an `admin` in `principals` has full access to the pico account.

Principals:

- `admin`
- `pico.sh`
- `pgs.sh`
- `tuns.sh`
- `pipe.pico.sh`
- `feeds.pico.sh`
- `prose.sh`
- `pastes.sh`

Other commands:

```bash
# list keys
ssh pico.sh keygen ls
# remove access
ssh pico.sh keygen revoke -i bob
# export ca keys
ssh pico.sh keygen export
# generates a new ca cert and revokes all generated keys
ssh pico.sh keygen rotate
```

# Payment model

Because admins can generate as many certs as they want and we want to encourage
that for security purposes, we will not monetize on a per user basis. To us that
sets up a counter-productive limitation that negatively impacts the user
experience.

Instead, we are going to make it a fixed rate per year. Just like `pico+` we are
going to require a minimum one year when purchasing a membership. And because we
see SSH certificates as a "pro" or "team" plan, we are going to ask for:

- $10/mo

When we start seeing larger teams or the number of support requests dramatically
increases then we reserve the right to re-evaluate on the next yearly payment
cycle.

# Upgrading from `pico+`

We will support the ability for a user to upgrade their plan. Initially, this
will be by contacting us.

# Teams

As mentioned in this RFC, this would provide official support for team accounts.
There are no limits on number of users or restrictions on usage at this point in
time.
