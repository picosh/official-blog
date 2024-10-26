---
title: status-5
date: 2024-01-02
tags: [status]
---

As part of the new year I wanted to kick things off with a quick stats review of
usage:

```
pastes users: 29
feeds users: 13
prose users > 1 post: 311
prose users > 10 posts: 50
prose users with posts within last year: 237 
irc bouncer users: 14
imgs users: 62
lists users with posts within last year: 48
```

Overall numbers feel pretty low, but I'm optimistic with a little marketing we
could make improvements.

So far we have been using these services for our own needs, as well as a way to
experiment with new technologies. One huge goal with pico is ergonomics and ease
of use. We have shown how ergonomic SSH apps can be for the terminal enthusiast.
In order to support that goal we have spent a lot of time on handling file
uploads via `scp`, `rsync`, and `sftp`. We can leverage these tools that every
hacker already has installed to provide services that might seem similar to
others, but is wholly unique to us.

We aren't stopping with just SSH apps and file upload services. We are going to
experiment with other ideas to provide high quality services to us and you all.

We have a couple area of focus for this year:

- officially launch [pgs.sh](https://pgs.sh)
- redesign sites (merge service docs into one static site, make them look
  prettier)
- make progress on [pico pro](/rfc-pico-pro-2023-11-06)
- create self-hostable SSH app for any object store

# self-hostable SSH app for any object store

This is a relatively new idea we had. What if we provided a docker image that
any user could run and instantly have the ability to use `scp`, `rsync`, or
`sftp` for your object store? All the user would need to do is provide their
object store provider (e.g. s3, r2, minio) as well as their API keys and our
docker image would handle the rest.

This could be a nice way advertise pgs.sh

We are going to try to post a status update once a week, just to let you all
know what we are working on and keep the pace steady for dev work.
