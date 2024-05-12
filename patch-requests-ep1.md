---
title: Patch Requests
description: The simplest git collaboration tool
date: 2024-05-11
---

We are trying to build the simplest git collaboration tool. The goal is to make
self-hosting a git server as simple as running an SSH server and hosting static
web assets -- all without sacrificing external collaborators.

> `git format-patch` isn't the problem and pull requests aren't the solution.

We are combining mailing list workflows with pull requests. In order to build
the simplest collaboration tool, we needed something as simple as generating
patches but the ease-of-use with pull requests.

# The Problem

Email is great as a decentralized system to send and receive changes (patchsets)
to a git repo. However, setting up your email client and understanding the
potential gotchas during that flow cannot be understated. Further, because we
are leveraging the email protocol for collaboration, we are limited by its
feature-set. For example, it is not possible to make edits to emails.

Further, when a contributor provides a patchset and receives feedback, the
contributor must submit another patchset via email. These are completely
separate and the only way to correlate them is via naming convention (e.g.
[PATCH] xxx v2). Now when reviewing patchsets submitted to a project, the user
must search for all versions of that particular patchset. These are separate
conversations with potentially very different patches spanning across the time
of a project. Maybe that's ok, but people are very used to a PR containing all
changes and reviews across time, and I think it makes a lot of sense to have a
single view of all conversations related to a change request.

Another issue with the email workflow is knowing how to properly reply to a
patchset. There is a lot of education on "doing patchsets right via email."

Github pull requests are easy to use, easy to edit, and easy to manage. The
downside is it forces the user to be inside their website to perform reviews.
For quick changes, this is great, but when you start reading code within a web
browser, there are quite a few downsides. At a certain point, it makes more
sense to review code inside your local development environment, IDE, etc.

Further, self-hosted solutions that mimic a pull request require a lot of
infrastructure in order to manage it. For example, before an external user who
wants to contribute to a repo, they first need to create an account and then
login. This adds quite a bit of friction for a self-hosted solution, not only
for an external contributor, but also for the code owner who has to provision
the infra.

# Introducing Patch Requests (PR)

Instead, we want to create a self-hosted git "server" that can handle sending
and receiving patches without the cumbersome nature of setting up email or the
limitations imposed by the email protocol. Further, we want the primary workflow
to surround the local development environment. Github is bringing the IDE to the
browser in order to support their workflow, we want to bring the workflow to the
local dev environment.

We see this as a hybrid between the github workflow of a pull request and
sending and receiving patches over email.

The basic idea is to leverage an SSH app to handle most of the interaction
between contributor and owner of a project. Everything can be done completely
within the terminal, in a way that is ergonomic and fully featured.

Notifications would happen with RSS and all state mutations would result in the
generation of static web assets so it can all be hosted using a simple file web
server.

We will be recording a video showcasing the workflow of submitting, reviewing,
and accepting a code change. But until that is done, you can see some print outs
of our fully functional prototype.

Here's the main help command:

```bash
$ ssh git.pico.sh help
NAME:
   ssh - Collaborate with external contributors to your project

USAGE:
   ssh [global options] command [command options]

DESCRIPTION:
   Patch requests (PR) are the simplest way to submit, review, and accept changes to your git repository.
   Here's how it works:
     - External contributor clones repo (git-clone)
     - External contributor makes a code change (git-add & git-commit)
     - External contributor generates patches (git-format-patch)
     - External contributor submits a PR to SSH server
     - Owner receives RSS notification that there's a new PR
     - Owner applies patches locally (git-am) from SSH server
     - Owner makes suggestions in code! (git-add & git-commit)
     - Owner submits review by piping patch to SSH server (git-format-patch)
     - External contributor receives RSS notification of the PR review
     - External contributor re-applies patches (git-am)
     - External contributor reviews and removes comments in code!
     - External contributor submits another patch (git-format-patch)
     - Owner applies patches locally (git-am)
     - Owner marks PR as accepted and pushes code to main (git-push)

COMMANDS:
   git-receive-pack  Receive what is pushed into the repository
   git-upload-pack   Send objects packed back to git-fetch-pack
   ls                List all git repos
   pr                Manage Patch Requests (PR)
   help, h           Shows a list of commands or help for one command

GLOBAL OPTIONS:
   --help, -h  show help
```

Here's the `pr` help command:

```bash
$ ssh git.pico.sh pr help
NAME:
   ssh pr - Manage Patch Requests (PR)

USAGE:
   ssh pr command [command options]

COMMANDS:
   ls       List all PRs
   create   Submit a new PR
   print    Print the patches for a PR
   stats    Print PR with diff stats
   summary  List patches in PRs
   accept   Accept a PR
   close    Close a PR
   reopen   Reopen a PR
   add      Append a patch to a PR
   comment  Comment on a PR
   help, h  Shows a list of commands or help for one command

OPTIONS:
   --help, -h  show help
```

# Conclusion

We will be keeping everyone updated on our development and most importantly,
when we can all start trying it.
