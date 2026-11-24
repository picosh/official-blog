---
title: abusing ssh certs to replace acls
date: 2026-11-24
tags: [ann]
draft: true
---

SSH certificates carry a list of principals, which sshd normally treats as the usernames you can log in as. We put permissions in there instead:

```bash
ssh-keygen -s pico-ca -I ci-blog -n pgs:deploy:blog -V +90d ci.pub
```

We don't keep a list of who can do what, because each cert says what it allows. This one can deploy one site, it expires in 90 days, you can limit it to an IP range, and you can revoke it early. You mint it offline with `ssh-keygen`, and the CA's private key never leaves your machine. It works with the ssh, rsync and git you already have, on every pico service including [picd](https://cd.pico.sh).

Last year we [added SSH certificates](/rfc-007-access-control) to lay the groundwork for fine-grained access. You add a certificate authority (CA) to your public keys, then sign a key for each machine that needs access. The principals on the cert say which services it can use.

That left two gaps. A cert for pgs could change every site on the account, so a CI job that deploys your blog could also delete your docs. And once you handed out a cert, the only way to take it back was to remove the CA, which broke every other cert it had signed.

# setup

Create a CA and add `pico-ca.pub` to your public keys in `ssh pico.sh`. You only do this once. Keep the private key off the machines you sign for, because it can log in to your whole account.

```bash
ssh-keygen -t ed25519 -f pico-ca -C pico-ca
```

The machine you're giving access to needs a key of its own. Sign its public key, then copy the `ci-cert.pub` that comes out next to the key. ssh picks it up from there.

```bash
ssh-keygen -t ed25519 -f ci -C ci
ssh-keygen -s pico-ca -I ci-blog -n pgs:deploy:blog -V +90d ci.pub
```

`-I` is the ID you'll see in your access logs, `-n` is what the cert allows, and `-V` is how long it lasts. Leave `ci.pub` itself out of your public keys. ssh falls back to the plain key when a cert is refused, and that key has no limits.

pico.sh and pipe also accept keys without an account, and ssh may offer your plain key first. Use `-i ci -o CertificateFile=ci-cert.pub -o IdentitiesOnly=yes` there.

# scopes

A scope is a principal that names a service, a role and a resource. In each recording, the top pane signs a cert on a laptop that has the CA. The bottom pane is the CI machine using it.

## pgs

`pgs:deploy:certs-demo` can deploy the `certs-demo` site. It can't touch another one, and `ls` only shows what it covers:

[![deploying a pgs site with a scoped cert and being refused on another site](/certs-pgs.gif)](/certs-pgs.gif)

`pgs:read` can only download. prose, pastes and feeds have `read` and `write` scopes for files. End a resource with `*` to match a prefix, like `pgs:deploy:blog*`.

## pipe

`pipe:pub:certs-demo` can publish to one topic. The laptop is subscribed to it and gets the message. The cert can't publish to another topic, and it can't subscribe to its own without `pipe:sub`:

[![publishing to a pipe topic with a scoped cert and being refused elsewhere](/certs-pipe.gif)](/certs-pipe.gif)

## tuns

`tuns:http:certs-demo` can open an HTTP tunnel with that name and no other:

[![opening a tunnel with a scoped cert and being refused on another name](/certs-tuns.gif)](/certs-tuns.gif)

Aliases have two scopes, so you can split the two ends of a private tunnel between certs. An alias is a TCP tunnel that only exists inside tuns, with no public port. One cert can open the `homelab` alias and nothing else, and another can connect to it and nothing else:

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

Scopes add up, so a single cert can deploy a site and announce it:

```bash
ssh-keygen -s pico-ca -I ci-blog -n pgs:deploy:blog,pipe:pub:deploys -V +90d ci.pub
```

A cert with only scopes can't manage the account or open the pico.sh TUI. A mistyped role refuses the cert. The [access control docs](https://pico.sh/access-control#scopes) list every scope.

# source addresses

You can also limit a cert to the IP addresses it's used from, with or without scopes. The first cert here is signed for the CI machine's address and works. The second is signed for a different network, so the same machine is refused. The machine's real address is masked as `203.0.113.7`:

[![a cert limited to an address working from it, and one for another network being refused](/certs-source-address.gif)](/certs-source-address.gif)

`source-address` takes a comma-separated list of IPv4 and IPv6 addresses or CIDR ranges.

# revoking

`ssh pico.sh certs` lists the unexpired certs your CAs signed that have been used recently. It reads them from your [access logs](https://pico.sh/access-logs), so there's nothing to register when you sign one.

Here a cert can reach pgs, picd and tuns. We revoke it by its ID, and all three refuse its next login:

[![listing certs and revoking one by its ID, after which pgs, picd and tuns refuse it](/certs-revoke.gif)](/certs-revoke.gif)

`revoke` without `--write` shows what it would revoke and changes nothing.

An ID covers every cert signed with exactly that ID. If a key leaked or a laptop was lost, revoke the key. That covers every cert for it, including ones you sign later.

Here we revoke a lost laptop's key, and both certs signed for it show up. A newly signed cert for the same key is refused as well. Then we undo it and the new cert works:

[![revoking a key, which refuses its certs and a newly signed one, then undoing it](/certs-revoke-key.gif)](/certs-revoke-key.gif)

A few things to know:

- Revoking stops new logins. Connections that are already open, like a tunnel, stay open until they close.
- If the key is also in your public keys, it can still log in without a cert. `certs revoke` warns you, and you need to remove it there too.
- On pico.sh and pipe, the key of a revoked cert is treated like any key without an account.
- Certs with scopes can't revoke or unrevoke anything.
- If the CA's private key leaks, remove the CA from your public keys.

The [access control docs](https://pico.sh/access-control#revoking-certificates) have the rest.

That's it. Let us know what you think on [IRC](https://pico.sh/irc).
