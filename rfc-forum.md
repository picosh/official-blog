---
title: RFC forum [draft]
description: proposal for single-tenant forum
date: 2022-10-11
tags: [rfc]
---

Forums used to dominate the web, but now there are instant chat apps like
discord, social link sharing apps like reddit, and knowledge sharing apps like
stackoverflow.  They all have their strengths, but I think forums can still be
relevant in 2022 and beyond.

We want to create a self-hosted forum service that leverages SSH for all
authenticated operations.  So creating threads, replying to threads, etc.,
would all happen via SSH.

We would have a simple read-only website to actually read the forum.

# Features

- self-hosted
- single tenant
- docker compose installation
- writing via SSH
- moderation via SSH
- reading via website
- css theming
- custom branding
- abilility to edit template files
- markdown for posts

# Technical ideas

## categories

Moderators should be able to create high-level categories for threads.  Maybe
this is accomplished via tagging.

## threads

Creating a thread within that post could be accomplished via SSH subcommand:

```bash
echo 'This is an example post, written in markdown.' | ssh forums.sh thread general
```

`thread` is the subcommand and `general` would be the category to post the
thread under.

## reply

```bash
echo 'I am replying to this post' | ssh forums.sh reply abc123
```

`abc123` in this case is an ID for the thread which will be shown on the thread
itself on the website.

## posts

Users would be able to edit posts by editing the markdown file they used to
create the post.

## moderation

Some ideas

Lock user:

```bash
ssh forums.sh lock user username
```

Lock thread:

```bash
ssh forums.sh lock thread abc123
```

Delete thread:

```bash
ssh forums.sh delete thread abc123
```

Delete post:

```bash
ssh forums.sh delete post abc123
```

## editing

This one is a little trickier.

We could take a few different approaches here.  We could suggest that the user
create "posts" in a local folder and then sync them to us like they would with
prose.  This would allow for better editing abilities.

`reply-to-some-thread.md`

```md
---
reply-to: abc123
---

I am replying to this post
```

```bash
scp reply-to-some-thread.md forums.sh:/
```

This would make it easier for the user to edit their posts.  If they want to
just echo their response quickly without creating a file, we could return a
unique id for that post which they could then download, edit, and then
reupload.

```bash
echo 'I am replying to this post' | ssh forums.sh reply abc123

ID: 11111
```

Then they could:

```bash
scp forums.sh:/11111 .
vim 11111
```

```md
---
reply-to: abc123
---

I am replying to this post, but also make an edit.
```

```bash
scp 11111 forums.sh:/
```

For the MVP I think the traditional approach of creating a file, adding
metadata, and the contents of the post.
