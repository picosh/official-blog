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
| **last updated** | 2025-11-07      |
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

- Admin signs up for pico+
- Admin runs `ssh pico.sh keygen -i bob -n tuns.sh,pgs.sh -V +52w` to generate a
  key on behalf of a user that lasts for 1 year (52 weeks)
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

# Teams

As mentioned in this RFC, this would provide official support for team accounts.
There are no limits on number of users or restrictions on usage at this point in
time.
