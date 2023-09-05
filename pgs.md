---
title: pgs.sh announcement
description: A zero-dependency static site hosting service for hackers
date: 2023-05-09
---

Hey all

It's been awhile since we've made an official announcement.

I wanted to show a sneak peak of something I've been working on the for the past
few months.

I build a lot of projects that involve static hosting and became frustrated by
how complicated it is in 2023. All I need to do is move files from my CI onto a
server that can serve the files. It shouldn't be as complicated as it is on GCP,
AWS, etc. And the ones that are marketed as easy (e.g. Cloudflare Pages,
surge.sh) still require the end-user to install a tool first.

With pgs.sh the user doesn't need to install anything. Signup is as simple as
SSHing into pgs.sh and creating an account. Creating new static sites is as easy
as copying files to pgs.sh.

To go even further, we have added features like instant promotion and rollback
to make it easier to manage deployments safely.

The entire service can be managed via SSH commands. Pasted below is our help SSH
command: https://erock.pastes.sh/pgs-cmds.md

This service is in closed beta, but if you join our irc channel #pico.sh @
libera.chat we will invite you to test it out.

I'd love to read some feedback on this service, thanks!
