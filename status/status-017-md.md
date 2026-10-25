---
title: status-17 - fall update
date: 2026-10-25
tags: [status]
draft: true
---

[pico.sh](https://pico.sh) is a set of services for developers that you use over SSH. Your SSH key is your account, and the tools you already have are the client. You publish a blog with rsync, host a static site with scp, share localhost with `ssh -R`, and stream data between machines with a pipe.

Our last big roundup was in [January](/status-014). Since then we've rewritten how rsync works on the platform, rebuilt the tuns console, brought lists back to prose, and added a lot to pgs and pipe. Here's what changed.

# rsync, natively

Every service that takes files accepts uploads from the rsync you already have installed. Until this month that went through a minimal rsync receiver. It handled the common cases, but every new flag meant another special case, and delta transfers and compression were out of reach.

We replaced it with a native Go implementation of the rsync protocol, versions 27 through 31. Our server now behaves like any other rsync server:

- Unchanged files are skipped by size and modification time, or by content with `-c`
- Changed files are sent as a delta against our copy
- `-z` compression with zlib or zlibx
- `--exclude`, `--include`, merge files and the other filter rules
- Every `--delete` mode, `--dry-run`, `--relative` and `--files-from`
- Downloads work the same way, with deltas and compression

![uploading a site with rsync, then uploading it again after changing one line](/status-17-rsync.gif)

File data streams to and from our object storage through fixed-size buffers. A 1 GB upload peaks at about 5 MB of memory on our side. We also sped up pgs uploads and serving while we were in there. The full list of options is in our [file uploads docs](https://pico.sh/file-uploads).

# tuns

[tuns](https://pico.sh/tuns) gives you HTTP, TCP, TLS and UDP tunnels to localhost over SSH. It runs on [sish](https://github.com/antoniomika/sish), the open source tunneling server we maintain.

![the tuns service console](/tuns-console-requests.png)

Every HTTP tunnel comes with a service console, and we [rebuilt it from scratch](/ann-039-tuns-service-console). It shows requests live with formatted JSON and form bodies, inline images, "Copy as curl" and replay. Filters take quoted phrases and `-term` to exclude. WebSocket connections show every frame in both directions. Streamed responses like server-sent events are captured as they arrive, and gzip, deflate, brotli and zstd bodies are decoded.

![opening a tunnel with the tunnel script and watching requests arrive](/status-17-tuns.gif)

You can also [ask tuns how to open a tunnel](/ann-040-tuns-commands). `ssh tuns.sh http 3000 dev` prints the ssh command for an HTTP tunnel, and there are commands for https, tcp, sni and udp. `ssh tuns.sh script` prints a POSIX shell function so you can just type `tunnel http 3000`.

Smaller changes:

- `host-header` now works with HTTPS upstreams, so you can put a tunnel in front of a remote HTTPS site
- Custom domains can use a `_tuns` TXT record, and `_sish` still works
- If your tunnel drops partway through a response, the visitor gets an error instead of a cut-off body that looks complete

# pgs

[pgs](https://pico.sh/pgs) is our static site host. You upload with rsync, scp or sftp and your site is live. This year it got [a batch of new features](/ann-035-pgs-features):

- Auto-forms: point an HTML form at `/pgs/forms/{name}` and we collect the submissions, which you read back with `ssh pgs.sh forms {name}`
- Password-protected sites with `ssh pgs.sh acl {project} --type http-pass --acl {password}`
- Projects prefixed with `private-` are private and can't be made public
- A `bin` project whose files delete themselves after two weeks, for quick sharing
- Uploads straight from a unix pipe: `echo "<p>hi</p>" | ssh pgs.sh /bin/index.html`
- The per-file limit for pico+ went from 50MB to 100MB
- We replaced our third-party HTTP cache with our own RFC 9111 implementation

![the login page of a password-protected pgs site](/status-17-http-pass.png)

# prose

[prose](https://prose.sh) is our blog platform. You write markdown and rsync it up.

Our [plain text lists](/ann-034-plain-text-lists) format is back. Write a post as a `.lxt` file and it renders as a list.

We also gave every blog a [new minimal default design](/ann-039-prose-blog-redesign): centered content, a 70ch max width, and headers anchored to their sections. Discovery now has a trending feed, and you can rename a post in place over sftp.

# pipe

[pipe](https://pipe.pico.sh) is authenticated pubsub over SSH. If you know how to use `|`, you know how to use pipe.

- Monitors: `ssh pipe.pico.sh monitor my-cron 1h` expects a publish to `my-cron` at least once an hour and alerts you through an RSS feed when one doesn't arrive
- Wildcard subscriptions: `ssh pipe.pico.sh sub 'deploys-*'`
- Round-robin delivery with `pub -d round_robin`, so a topic can feed a pool of workers
- `?prefix=` on pipe-web to split a stream into messages

![a wildcard subscriber receiving messages from three topics](/status-17-pipe.gif)

![creating a monitor, pinging it and checking its status](/status-17-monitor.gif)

The [pipe docs](https://pico.sh/pipe) cover all of these.

# the platform

Free accounts now need an [invite](/ann-038-pico-invite-system) from an existing user or a pico+ member. Bots found our free services this year and flooded prose's discovery page, and invites let us keep a free tier instead of putting everything behind pico+. If you want one and don't know anyone, ask us on [IRC](https://pico.sh/irc) or email hello@pico.sh.

- `ssh pico.sh dns-check example.com` shows where a domain points and checks its TXT records for pgs, prose and tuns
- `ssh pico.sh access-logs` lists every time one of your keys signed in over the last 30 days, labeled with the key's name
- Site analytics now break visits down by device
- `ssh pico.sh` with no command, or one it doesn't know, prints help instead of hanging

![checking a custom domain's records with dns-check](/status-17-dnscheck.gif)

# what's next

We're building a CI service ([pici](https://ci.pico.sh)) and a CD service ([picd](https://cd.pico.sh)) that run entirely over SSH. They run on our own hardware in a colo, and the beta sites are up.

We're also working on [patchbin](https://pr.pico.sh), our git collaboration service where `ssh pr.pico.sh pr create` replaces `git send-email`.

That's it. Come say hi on [IRC](https://pico.sh/irc).
