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

We want to enable users to have more fine-grained control over what pubkeys have access to what pico services.

We accomplish access control using
[SSH certificates](https://goteleport.com/blog/how-to-configure-ssh-certificate-based-authentication/).
In particular, there's a `principals` field that we can leverage for role-based
access. When an admin generates a key for a teammate, a limited-access machine,
or a robot user, they can specify which services they have access to within the
`principals` field.

Workflow:

- Admin runs `ssh-keygen -i bob -n tuns.sh,pgs.sh -V +52w` to generate a
  key on behalf of a user that lasts for 1 year (52 weeks)
- Admin shares key with user
- User has access to the pico services specified in the principals list

if a user has `pico.sh` in their `principals` then they have access to the TUI,
but not the ability to generate keys or modify public keys.

Only an `admin` in `principals` has full access to pico account management.

Principals:

- `admin`
- `pico`
- `pgs`
- `tuns`
- `pipe`
- `feeds`
- `prose`
- `pastes`

# Revocation

We will provide the admin with the ability to revoke public key access to their account services.  Admins will be able to control revocations in the TUI.

# Team Accounts

With this feature it could theoretically support teams to use pico.  An admin can generate keys and send them to users so they can perform actions on behalf of the account.

There are no limits on number of users or restrictions on usage at this point in
time.

This will **not** change the behavior of the subdomains we create.  They will still exist under the primary user name.

The `-i` identity flag will be sent throughout our logs so users can see what pubkey performed an action.
