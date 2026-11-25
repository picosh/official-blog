---
title: replacing acls with ssh certs
date: 2026-11-24
tags: [ann]
---

SSH certificates carry a list of principals, which sshd normally treats as the usernames you can log in as. We put permissions in there instead:

```bash
ssh-keygen -s pico-ca -I ci-blog -n pgs:deploy:blog -V +90d ci.pub
```

This cert can deploy `blog` for 90 days. You can also limit it to an IP range and revoke it early. We don't keep a list of who can do what, because each cert says what it allows. You sign it offline with `ssh-keygen`, and the private key of the certificate authority (CA) stays on your machine. Certs work with the ssh, rsync and git you already have, on every pico service including [picd](https://cd.pico.sh).

[pico](https://pico.sh) is a set of hosted services for developers that you use over SSH. Your SSH key is your login, and there's nothing to install. You can deploy static sites with [pgs](https://pico.sh/pgs), expose local services with [tuns](https://pico.sh/tuns), send messages between machines with [pipe](https://pico.sh/pipe), write a blog on [prose](https://pico.sh/prose), and push Docker Compose projects to picd.

Last year we [added SSH certificates](/rfc-007-access-control) to lay the groundwork for fine-grained access. You add a CA to your public keys, then sign a key for each machine that needs access. The principals on the cert say which services it can use.

Until now, a cert for pgs could change every site on the account, so a CI job that deploys your blog could also delete your docs. Once you handed out a cert, the only way to revoke it was to remove the CA, which broke every other cert it had signed. You can now scope a cert to individual resources and revoke it separately.

# how ssh certs work

Normally a server keeps a list of the public keys that can log in. If a key should only be able to do some things, the server has to store that too. That's an ACL: a table of who can do what, kept on the server and checked on every request. Giving a new CI job access means changing the table.

A certificate moves that information to the client. It's a public key with some fields attached, signed by another key, the CA. A server that trusts the CA can accept any key the CA signed, without having seen that key before. You can read the fields with `ssh-keygen -L`:

```bash
$ ssh-keygen -L -f ci-cert.pub
ci-cert.pub:
        Type: ssh-ed25519-cert-v01@openssh.com user certificate
        Public key: ED25519-CERT SHA256:WX9xs8xPZAGt7/JUgkX4tytbLZjNcH6M+m/nPLPABqE
        Signing CA: ED25519 SHA256:PcuZOO1bzDhZ59Gvh8dDYIbeRvtHDb8LrWopOxkCwgo (using ssh-ed25519)
        Key ID: "ci-blog"
        Serial: 0
        Valid: from 2026-11-25T04:58:00 to 2027-02-23T04:59:11
        Principals:
                pgs:deploy:blog
        Critical Options: (none)
        Extensions:
                permit-X11-forwarding
                permit-agent-forwarding
                permit-port-forwarding
                permit-pty
                permit-user-rc
```

The signature covers every field, so changing any of them makes the cert invalid. The cert holds no secrets and is useless without the private key that goes with it, because the client still has to prove it has that key.

A principal is only a string, and the server decides what it means. With a trusted CA, sshd checks that one of them is the username you're logging in as, unless you configure it to accept other names. Our services are SSH servers written in Go, so they can read a principal as a permission.

When a cert logs in, we check that:

1. Its principals allow something on this service.
2. The CA's signature is valid and the cert hasn't expired.
3. The CA is in an account's public keys. That's how we know which account the cert acts for.
4. Nobody on that account revoked it.
5. The client's IP address is allowed, if the cert limits it.

After that, each action is checked against the principals. We store the CA's public key and a list of what's been revoked, and the permissions stay in the cert. The extensions above are for sshd and have no effect on pico.

You can't edit a cert. To change a machine's permissions, sign a new one and revoke the old one if you're taking access away.

# setup

Create a CA and add `pico-ca.pub` to your public keys in `ssh pico.sh`. You only do this once. Keep the private key off the machines you sign for, because it can log in to your whole account.

```bash
ssh-keygen -t ed25519 -f pico-ca -C pico-ca
```

The machine you're giving access to needs a key of its own. Sign its public key, then copy the resulting `ci-cert.pub` next to the machine's key. ssh picks it up from there.

```bash
ssh-keygen -t ed25519 -f ci -C ci
ssh-keygen -s pico-ca -I ci-blog -n pgs:deploy:blog -V +90d ci.pub
```

`-I` is the ID you'll see in your access logs, `-n` is what the cert allows, and `-V` is how long it lasts. Leave `ci.pub` itself out of your public keys. ssh falls back to the plain key when a cert is refused, and that key has no limits.

pico.sh and pipe also accept keys without an account, and ssh may offer your plain key first. Use `-i ci -o CertificateFile=ci-cert.pub -o IdentitiesOnly=yes` there.

# scopes

A scope is a principal that names a service, a role and a resource. `pgs:deploy:blog` allows deploying the `blog` site on pgs. Anything a cert's scopes don't name is refused. In the recordings in this section, the top pane is a laptop with the CA and the bottom pane is the CI machine using the cert.

## pgs

`pgs:deploy:certs-demo` can deploy the `certs-demo` site. It can't touch another one, and `ls` only shows what it covers:

[![deploying a pgs site with a scoped cert and being refused on another site](/certs-pgs.gif)](/certs-pgs.gif)

`pgs:read` can only download. prose, pastes and feeds have `read` and `write` scopes for files. End a resource with `*` to match a prefix, like `pgs:deploy:blog*`.

## pipe

`pipe:pub:certs-demo` can publish to the `certs-demo` topic. The laptop is subscribed to it and gets the message. The cert can't publish to another topic, and it can't subscribe to its own without `pipe:sub`:

[![publishing to a pipe topic with a scoped cert and being refused elsewhere](/certs-pipe.gif)](/certs-pipe.gif)

## tuns

`tuns:http:certs-demo` can open an HTTP tunnel named `certs-demo`. Other names are refused:

[![opening a tunnel with a scoped cert and being refused on another name](/certs-tuns.gif)](/certs-tuns.gif)

An alias is a TCP tunnel that only exists inside tuns, with no public port. Separate scopes control who can open an alias and who can connect to it. Here we sign one cert to open `homelab` and another to connect to it:

```bash
ssh-keygen -s pico-ca -I homelab -n tuns:alias:homelab -V +90d homelab.pub
ssh-keygen -s pico-ca -I phone -n tuns:connect:homelab -V +90d phone.pub

# on the homelab
ssh -R homelab:22:localhost:22 tuns.sh

# on the phone
ssh -J tuns.sh {user}-homelab
```

The phone can ssh to the homelab through tuns. Its cert can't open tunnels or reach any other alias, and the homelab's cert can't connect to anything. If the phone is lost, revoke its key and the homelab keeps its tunnel.

There are scopes for SNI, TCP and UDP tunnels too.

## picd

`picd:deploy:certs-demo` can push one project, and creates it on the first push. The other projects in the account don't show up, and the cert can't open a shell:

[![pushing a picd project with a scoped cert and being refused on another project and a shell](/certs-picd.gif)](/certs-picd.gif)

Scopes add up, so a single cert can deploy a site and publish to the `deploys` topic:

```bash
ssh-keygen -s pico-ca -I ci-blog -n pgs:deploy:blog,pipe:pub:deploys -V +90d ci.pub
```

A cert with only scopes can't manage the account or open the pico.sh TUI. If you mistype a role, the cert is refused. The [access control docs](https://pico.sh/access-control#scopes) list every scope.

# source addresses

Scopes limit what a stolen key can do. You can also limit where it works by signing the cert for certain IP addresses, with or without scopes:

```bash
ssh-keygen -s pico-ca -I ci-blog -n pgs:deploy:blog -V +90d -O source-address=203.0.113.7/32 ci.pub
```

`source-address` is a critical option. The format has two kinds of options: a server can ignore an extension it doesn't know, but it has to refuse a cert with a critical option it doesn't know. That way a restriction can't be skipped by a server that doesn't support it. `source-address` is the only critical option we support, so we refuse a cert with any other.

In this recording, the first cert is signed for the CI machine's address and works. The second is signed for a different network, so the same machine is refused. The machine's real address is masked as `203.0.113.7`:

[![a cert limited to an address working from it, and one for another network being refused](/certs-source-address.gif)](/certs-source-address.gif)

`source-address` takes a comma-separated list of IPv4 and IPv6 addresses or CIDR ranges.

# revoking

A cert is valid until it expires, and nobody has to ask the CA before accepting it. That's what lets you sign certs offline, and it's also why they're hard to take back. The simplest answer is a short expiry, so a leaked cert stops working by itself. For the time before that, the server needs a list of certs to refuse. The list stays small because it only holds the exceptions.

`ssh pico.sh certs` lists the unexpired certs your CAs signed that have been used recently. It reads them from your [access logs](https://pico.sh/access-logs), so there's nothing to register when you sign one.

Here a cert can reach pgs, picd and tuns. We revoke it by its ID, and all three refuse its next login:

[![listing certs and revoking one by its ID, after which pgs, picd and tuns refuse it](/certs-revoke.gif)](/certs-revoke.gif)

`revoke` without `--write` shows what it would revoke and changes nothing.

An ID is text you choose with `-I`, so you can sign many certs with the same one. Revoking an ID covers every cert signed with exactly that ID. If a key leaked or a laptop was lost, revoke the key. That covers every cert for it, including ones you sign later.

Here the bottom pane is an old laptop that got lost. We revoke its key, and both certs signed for it show up. A newly signed cert for the same key is refused as well. Then we undo it and the new cert works:

[![revoking a key, which refuses its certs and a newly signed one, then undoing it](/certs-revoke-key.gif)](/certs-revoke-key.gif)

- Revoking blocks new logins without closing existing connections.
- Remove the key from your public keys to block logins without a cert.
- On pico.sh and pipe, the key of a revoked cert is treated like any key without an account.
- Certs with scopes can't revoke or unrevoke anything.
- If the CA's private key leaks, remove the CA from your public keys.

The [access control docs](https://pico.sh/access-control#revoking-certificates) have the rest.

Let us know what you think on [IRC](https://pico.sh/irc).
