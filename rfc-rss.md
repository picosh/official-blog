---
title: RFC rss service
description: A proposal for an RSS service
date: 2022-12-31
---

RSS/Atom is a great companion in the smol web.  It's relatively standard, easy
to write, easy to consume, and provide users with choice on how to view their
feeds.

I think an RSS reader as an SSH app could be useful.

# market research

Here are some other RSS readers in the market: https://erock.lists.sh/rss-readers

# features

- Keypair authentication
- Ability to upload feeds
- Ability to upload [opml](https://en.wikipedia.org/wiki/OPML) file
- Ability to categorize feeds via tags
- We would fetch the feeds and keep them up-to-date
- We can send an email digest (if they provide their email)
- Terminal view of the feeds, piped to w3m
- We could provide aggregate rss feeds for collections
- Web view for the feeds?

# what can we offer over the other readers?

We would try to provide a great reading experience from the terminal.  No need
to install an RSS reader like newboat.  No need to sync a config file across
multiple apps.  Just SSH into our app and read some content.  Furthermore, many
of the readers do not provide an rss-to-email feature and most rss-to-email
services do not provide readers so there's an interesting opportunity here to
capture both audiences.

The other nice thing about an RSS reader apps is that it ties into our other
services that leverage RSS as well.  It's hard to let users know of new
features when they aren't notified about them.  It would be nice to have a
generic way for users to subscribe to us as well as other content they enjoy.

By providing a service that emails users of our services, it would hopefully
improve our communication with our users.

I also think a web version could be interesting.  Anyone could navigate to any
user's feed collection and read its content.  This would also provide mobile
support for users since they can just navigate to our website.  The only issue
is we might have to deal with content security policy and ensuring we could
render the html content consistently.  It definitely opens us open to a bunch
of edge cases.

# how it works

A user would `scp` an `opml` file, a file containing a lists of rss feeds, or
`echo "<feed>" | ssh reads.sh`.  

We would dedupe the feeds and add them to our `posts` table.  Because an RSS
feed can contain a bunch of metadata about a feed, we should capture as much of
that as possible inside the `posts` table.  The downside is we use `posts` for
a lot of our services (e.g. lists, prose, and pastes) so we want to be careful
not to overload this table.  Having said that, I think an rss feed fits into
the post paradigm.  We just need to add a `data jsonb` column to `posts`.

```sql
ALTER TABLE posts ADD COLUMN data jsonb;
```

## fetching

Triggers for fetching feeds:

- User logs into the SSH app
- Prior to sending out daily email digest
- When the user requests to view the feed on web site

Fetching feeds can be a little tricky since some feeds do not provide the html
inside their atom entry.  Instead they provide a link for users to click on to
navigate to their site.  This kind of defeats the purpose of using RSS so we
could just render the link and force users to open their browser.  Or we fetch
the link provided in the atom entry and store the html in our database.  This
would probably provide a better user experience but it opens us open to a slew
of edge cases and weird behavior.

## email digest

I also think that if we do send out a daily digest, we add a button in the
email that they need to click within 30 days or else we disable sending them an
email.  They click the button in the email -> we delay shutdown for 30 days.

## tracking feed entries

We would probably create a separate table for the feed results in order to
optimize storing an retrieval.

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

## queue system

We will probably also want a queuing system.  I figured we could just build one
that fits our purposes inside our database.

```sql
CREATE TYPE JOB_STATUS AS ENUM ('in_progress', 'success', 'fail');
CREATE TYPE JOB_TYPE AS ENUM ('fetch_feed');

CREATE TABLE IF NOT EXISTS app_queue(
  id          uuid NOT NILL DEFAULT uuid_generate_v4(),
  post_id     uuid NOT NULL,
  status      JOB_STATUS,
  type        JOB_TYPE,
  input       jsonb # params needed to execute job
  output      jsonb # result of job
  created_at  timestamp without time zone NOT NULL DEFAULT NOW(),
  CONSTRAINT  queue_pkey PRIMARY KEY (id),
  CONSTRAINT  fk_queue_posts
    FOREIGN KEY(post_id)
  REFERENCES posts(id)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);
```

# metadata

I haven't figured out a great way for users to add metadata to their feeds.
For example, if they want to add tags to a feed so they could view a collection
of feeds in one list.  We could do it within the CMS but I feel like it would
be better if there were a file format that could do that for us.  the `opml`
format seems like a good candidate.

I like the idea of storing the results in the database, but I could also see an
argument for using something more ephemeral like redis.

# is this a premium service?

The litmus test for a premium service at pico is: does it cost us more
resources to keep the service up and running?

I think creating, categorizing, and viewing the results of your feeds should be
free.  The premium service would be the email digest component.  We could also
offer an always fetching feature for premium users.

# risks

- RSS readers have been done before
- Syncing feeds can be costly in terms of compute resources
- Following atom entry links to the webpage puts us in the scraping category
  which opens us up to stability issues (e.g. some sites deny scrapers)
- Web view might run into content security policy issues
