---
title: status-8
description: pico.sh platform update
date: 2024-05-01
tags: [status]
---

Greetings.

Another month, another update. There's quite a bit of activity happening within
the pico platform, so I'll try to be brief.

I want to start with deprecations since I don't want them hidden:

# Deprecation: 0-byte file deletion

When we first created pico.sh we only supported `scp`. At the time we didn't
have a great way to remove files via our CLI. So we came up with an API to
upload a 0-byte file in order to delete it.

Now that we have much better ways to delete files (e.g. `sftp`) this feature is
less useful. Further, it is hindering some new features that we are building
(e.g. official support for `sshfs`), so we decided to kill this feature.

This change will be live **May 14, 2024**.

# Deprecation: CSP override for `pgs.sh` subdomains

We recently added support to override the
[default CSP](https://pico.sh/pgs#content-security-policy) when accessing a
user's site on the `pgs.sh` domain. We noticed a lot of users hitting CSP errors
when trying out `pgs.sh` and we felt it as well. However, because we are
currently not on the [Public Suffix List](https://publicsuffix.org/) and users
can host whatever content they want on `pgs.sh` we have unfortunately opened
ourselves up to abuse and we do not feel comfortable with that.

So we are reverting that change and making it impossible to override our default
CSP when accessing sites on the `pgs.sh` domain.

If you are running into CSP issues our official solution is to create a
[custom domain](https://pico.sh/custom-domains) which does not have any security
headers associated with it by default.

This change will be live **May 14, 2024**.

# pico.sh and IRC chat

All of our realtime communication happens on [IRC](https://pico.sh/irc). We also
offer a free, public instance of [soju](https://soju.im) which is an IRC
bouncer. IRC bouncers are a way for users to stay logged into IRC without having
a client directly connected to the IRC server. The biggest benefit is being
"always online" and having a persistent chat history.

Even with a modern IRC bouncer, it's still difficult to get things working
properly. In order to join our IRC channel, a user needs to:

- Understand how a bouncer works
- Create a pico.sh account
- Create an pico.sh API token
- Configure an IRC client to connect to our bouncer
- Create a libera account
- Connect our bouncer and libera by adding a network
- Joining our #pico.sh channel

This is a lot, especially if you just want to pop in and say hi. As a result, we
are constantly trying to hack ways to make this process easier for new users.

Well last week Antonio and I hacked together a solution that eliminates some of
these steps.

As of today, we are happy to announce a public instance of senpai (a terminal
IRC client) for all pico users to use. New steps to getting started:

- Create a pico.sh account (via `ssh pico.sh`)
- Select "Chat" in the TUI
- Create a libera account
- Add the libera network to our bouncer
- Join #pico.sh

We plan on continuing to improve this flow but hopefully users will find it
easier to chat with us on #pico.sh!

# Experimenting with git collaboration

If you want to self-host a git server with the ability to have external
contributors, you have two choices:

- Receive patches (`git format-patch`) or "pull requests" (`git request-pull`)
  via email
- A full blown collaboration suite like gitea et al.

For a self-hosted code forge, both solutions miss the mark. The former requires
external contributors to properly configure git to send email as well as
properly setting up their email client to handle code reviews and follow-up code
changes.

The latter requires a bunch of infrastructure to host and maintain and further
requires external contributors to create an account before submitting a change.

Both solutions add way too much friction for external collaborators.

So, we spent some time experimenting with ideas and think we have something that
could alleviate this friction.

The goal with this new project is not to be yet-another-code-forge, rather the
simplest way to host your own code forge as well as the simplest way for
external collaborators to contribute to your git projects.

This project is under active development and we will continue to share our
development with you all.

# End

That's it for now, thanks for reading!
