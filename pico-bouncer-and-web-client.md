---
title: pico irc bouncer and web client guide
date: 2023-10-13
tags: [guide]
---

Hey everyone!

We are excited to announce that we have a hosted IRC bouncer and web client that
all pico users can use.

# Guide

- [soju man page](https://soju.im/doc/soju.1.html)
- [bouncer: ircs://irc.pico.sh:6697](ircs://irc.pico.sh:6697)
- [web client: chat.pico.sh](https://chat.pico.sh)

## Generate a login token for bouncer

![pico-token-menu](/pico-token-menu.png)

- SSH into a pico service CMS (e.g. `ssh prose.sh`)
- Select "tokens" submenu
- Type "n" to generate a new token
- Save token someplace safe

## Log into [chat.pico.sh](https://chat.pico.sh)

- You'll be redirected to [auth.pico.sh](https://auth.pico.sh) which implements
  a fake oauth2 service
- Enter the token from above
- Click submit

## Back to [chat.pico.sh](https://chat.pico.sh)

![irc-remember-me](/irc-remember-me/x500)

- Click "remember me" (this is important)
- You'll see an error "Cannot interact with channels and users on the bouncer
  connection. Did you mean to use a specific network?" that's okay
- Message `BouncerServ` (`/msg BouncerServ help`) to configure the bouncer

## Connecting to `irc.libera.chat/#pico.sh`

- `/msg BouncerServ help`
- `network create -addr irc.libera.chat -name libera -nick <user> -enabled false`
- `sasl set-plain -network libera <user> <pass>`
- `network update libera -enabled true`
- `/j #pico.sh`
- Join any other channels or networks using the same method!

# Acknowledgments

- [soju (bouncer)](https://git.sr.ht/~emersion/soju)
- [gamja (web client)](https://git.sr.ht/~emersion/gamja)
