---
title: rfc-7 access control
description: Controlling access to your pico account with ssh certificates
date: 2025-08-03
tags: [rfc]
aliases:
  - /rfc-007-teams
---

|            |                 |
| ---------- | --------------- |
| **status** | published       |
| **site**   | https://pico.sh |

# Access control

We want to enable users to have more fine-grained control over what pubkeys have access to what pico services.

We accomplish access control using [ssh certificates](https://goteleport.com/blog/how-to-configure-ssh-certificate-based-authentication/). In particular, there's a `principals` field that we can leverage for role-based access. When an admin generates a key for a teammate, a limited-access machine, or a robot user, they can specify which services they have access to within the `principals` field.

# Workflow

The owner of the pico account **must** generate and manage their own ssh certificate. We will never have access to the private key.

```bash
# admin creates ssh ca keypair (or uses one they already have)
ssh-keygen -t ed25519 -f ./ca_user_ed25519 -C "pico-ca"

# alice generates a normal ssh keypair (or uses one they already have)
# alice sends pubkey to admin
ssh-keygen -t ed25519 -f alice -C "alice@example.com"

# admin signs alice pubkey with admin ca private key to produce the user certificate
# this generates a new cert-signed pubkey: `alice-cert.pub`
ssh-keygen -s ./ca_user_ed25519 \
           -I "alice@$(date +%F)" \
           -n tuns,pgs \ # this grants alice access to those services
           -V +52w \
           alice.pub

# admin sends alice-cert.pub to alice and then they can use their keypair
# note: you don't normally need to provide the `-o CertificateFile=` since ssh will find it automatically
# but we wanted to include for completeness
rsync -e "ssh -i ./alice -o CertificateFile=./alice-cert.pub" -rv ./public/ pgs:/site/
```

Only an `admin` in `principals` has full access to pico account management and the pico.sh TUI.

Principals:

- `admin`
- `pgs`
- `tuns`
- `pipe`
- `feeds`
- `prose`
- `pastes`

# Revocation

We will provide the admin with the ability to revoke public key access to their account services. Admins will be able to control revocations in the TUI.

# Access Logs

We will record whenever an ssh cert tries to access the platform and present access logs to admins of the account in our TUI. This is where it is important to provide a meaningful `-I` flag when signing a pubkey as that is what you will see in the access logs.

# Team Accounts

With this feature it could theoretically support teams to use pico. An admin can sign user pubkeys and send them to users so they can perform actions on behalf of the account.

There are no limits on the number of ssh certificates that are added or the number of pubkeys signed by those ssh certificates. We see this as a great way to control access to our platform and we want to encourage users to use it.

This will **not** change the behavior of the subdomains we create. They will still exist under the primary user name.
