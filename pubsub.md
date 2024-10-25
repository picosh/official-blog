---
title: "pipe: our pubsub ssh service"
description: Authenticated *nix pipes over ssh
tags: [announcement]
---

[pipe.pico.sh](https://pipe.pico.sh) is our new managed pubsub service that
enables networked `*nix` pipes over `ssh`.

`pipe` is built off our generic [pubsub](https://github.com/picosh/pubsub)
golang pkg.

# Example

```bash
# term 1
echo "hello world!" | ssh pipe.pico.sh pub hello
# term 2
ssh pipe.pico.sh sub hello
```

> Go to [pipe](https://pipe.pico.sh) for more examples.

# Why?

We needed an event system to communicate between our services and users. We
could have used an off-the-shelf solution like mqtt but being a hacker lab where
we like to experiement with the ssh protocol, we thought we could create
something even simpler and just as powerful.

Further, authentication is handled automatically with ssh. We also don't like
asking users to install yet-another-cli-tool.

# How we using it?

For awhile now we have wanted a couple of features that required an event
system:

- Providing user logs
- Webhooks for [imgs](https://pico.sh/imgs) and other ideas

## User logs

We have been spending a lot of time structuring our service logs in an effort ot
make it easier for us to debug issues. Futher, it's very common for a user to
submit a bug request only to discover it was some user configuration error
causing the "bug." If we had a way to provide the logs we use to our users, they
could theoretically debug the issue themselves.

So while building `pipe` we figured out a robust way to provide realtime logs to
users with minimal effort. At `pico` we have standardized on
[`slog`](https://pkg.go.dev/log/slog) which has a middleware system to integrate
with third-party services like sentry or other log drains.

The moment we are able to determine the user within our services, we add a tag
to the logs which then lets us **scope** the logs to a specific user. These are
the logs the end-user will be able to see.

So we
[built a `pipe` integration](https://github.com/picosh/pubsub/blob/main/log/log.go#L311)
with `slog` that will send all our service logs to `log-drain` topic in our
`pipe` service.

The benefits are multi-fold:

- Admins (us) have quick access to a central log-drain
- Users can now access their **scoped** user logs which are the same logs we
  have access to
- Since we productized our logs, we are spending a lot more time tuning and
  formatting them to be more useful than ever before

Further, because our pubsub system leverages ssh we get automatic authentication
as well as the ability to easily pipe our logs to something like `jq`:

```bash
ssh pico.sh logs | jq
```

It's really that simple!

## Webhooks for `imgs`

We wanted to provide a way for users to receive docker registry notifications.

```bash
# term1: subscribe to updates, pull and redeploy
ssh imgs.sh sub alpine:latest | docker compose pull && docker compose up -d
# term2: some ci system pushing an image to imgs registry
ssh -L 1338:localhost:80 -N imgs.sh
docker push localhost:1338/alpine:latest
```

We are excited about this service and thinks it's pretty useful.
