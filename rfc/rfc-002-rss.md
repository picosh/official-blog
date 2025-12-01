---
title: rfc-2 rss-to-email service
description: An RSS service
date: 2022-08-10
tags: [rfc]
---

|                  |                       |
| ---------------- | --------------------- |
| **status**       | published             |
| **last updated** | 2024-12-04            |
| **site**         | https://pico.sh/feeds |

RSS/Atom is a great companion in the smol web. It's relatively standard, easy to write, easy to consume, and provide users with choice on how to view their feeds.

We think an RSS service using an SSH app could be useful to the pico.sh platform. We like the idea of our notification system be completely opt-in, including for [pico+](/rfc-004-pico-plus) users. We can also build internal tooling around RSS. For example, we can monitor all [new sites on pages](https://pgs.sh/rss). Further this can be just as useful to feeds outside of pico.

This service can be run with three small go services:

- An SSH app to receive feed files
- A cron job to fetch feeds and send digests
- A web service for keep-alive events

# features

- Keypair authentication
- Ability to upload feeds
- Ability to upload [opml](https://en.wikipedia.org/wiki/OPML) file
- We would manage fetching feeds and keeping them up-to-date
- We could send an email digest (if they provide their email)

# how it works

A user would copy a file containing a lists of rss feeds.

It doesn't matter how many feed files the user uploads. Because an RSS feed can contain a bunch of metadata about a feed, we should capture as much of that as possible when presenting it to the user.

## fetching

We want to be smart about how we fetch feeds because it could be resource intensive if the service gets big enough.

For now, we are simply showing what we can in the email and the rest are links to the originating sites.

## email digest

I also think that if we do send out a daily digest, we add a button in the email that they need to click within 6 months or else we disable sending them an email. They click the button in the email and then we delay disabling it for 6 months.

## tracking feed entries

We would probably create a separate table for the feed results in order to optimize storing an retrieval.

```sql
CREATE TABLE IF NOT EXISTS feed_entry (
  id          uuid NOT NILL DEFAULT uuid_generate_v4(),
  post_id     uuid NOT NULL,
  read        boolean NOT NULL DEFAULT false,
  author      character varying(250),
  category    character varying(250),
  published   timestamp without time zone NOT NULL DEFAULT NOW(),
  rights      character varying(2000),
  source      character varying(2000),
  content     text,
  contributor character varying(250),
  atom_id     character varying(250),
  link        character varying(2000),
  summary     text,
  title       character varying(250),
  created_at  timestamp without time zone NOT NULL DEFAULT NOW(),
  updated_at  timestamp without time zone NOT NULL DEFAULT NOW(),
  CONSTRAINT  entry_unique_atom_id UNIQUE (atom_id, post_id),
  CONSTRAINT  feed_entry_pkey PRIMARY KEY (id),
  CONSTRAINT  fk_entry_posts
    FOREIGN KEY(post_id)
  REFERENCES posts(id)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);
```

# conclusion

RSS is a standard way to notify users of new content on a site and we see it as critical to the function of pico.sh.
