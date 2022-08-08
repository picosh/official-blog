---
title: RFC rss service
description: A proposal for an RSS service
date: 2022-12-31
---

RSS/Atom are a great companion in the smol web.  It's relatively standard, easy
to write, easy to consume, and provide users with choice on how to view their
feeds.

I think an RSS reader as an SSH app could be really useful.

Here are some other RSS readers in the market: https://erock.lists.sh/rss-readers

Features:

- Keypair authentication
- Ability to upload feeds
- Ability to upload [opml](https://en.wikipedia.org/wiki/OPML) file
- Ability to categorize feeds via tags
- We would fetch the feeds and keep them up-to-date
- We can send an email digest (if they provide their email)
- Terminal view of the feeds, piped to w3m
- We could provide aggregate rss feeds for collections
- Web view for the feeds?

## what can we offer over the other readers?

We would try to provide a great reading experience from the terminal.  No need
to install an RSS reader like newboat.  No need to sync a config file across
multiple apps.  Just SSH into our app and read some content.  Furthermore, many
of the readers do not provide an rss-to-email feature and most rss-to-email
services do not provide readers.

The other nice thing about an RSS reader apps is that it ties into our other
services that leverage RSS as well.  We have seen two major downsides to not
recording email addresses for our services:

- Users **must** subscribe to our RSS feed to receive updates
- Lost private key and need to recover account

By providing a service that emails users of our services, it would hopefully
improve communication.

I also think a web version could be pretty great.  Anyone could navigate to any
user's feed collection and read its content.  This would also provide mobile
support for users since they can just navigate to our website.  The only issue
is we might have to deal with content security policy and ensuring we could
render the html content consistently.  It definitely opens us open to a bunch
of edge cases.

## how it works

A user would `scp` an `opml` file, a file containing a lists of rss feeds, or
`echo "<feed>" | ssh reads.sh`.  

We would dedupe the feeds and add them to our `posts` table.

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

I also think that if we do send out a daily digest, we add a button in the
email that they need to click within 30 days or else we disable sending them an
email.  They click the button in the email -> we delay shutdown for 30 days.

We would probably create a separate table for the feed results in order to
optimize storing an retrieval.

`feed_entry`

```
id          uuid
post_id     uuid
author      varying char(250)
category    varying char(250)
published   datetime
rights      varying char(2000)
source      varying char(2000)
content     text
contributor varying char(250)
atom_id     varying char(250)
link        varying char(2000)
summary     text
title       varying char(250)
created_at  datetime
updated_at  datetime
```

I haven't figured out a great way for users to add metadata to their feeds.
For example, if they want to add tags to a feed so they could view a collection
of feeds in one list.  We could do it within the CMS but I feel like it would
be better if there were a file format that could do that for us.  the `opml`
format seems like a good candidate.

I like the idea of storing the results in the database, but I could also see an
argument for using something more ephemeral like redis.

## is this a premium service?

The litmus test for a premium service at pico is: does it cost us more
resources to keep the service up and running?

I think creating, categorizing, and viewing the results of your feeds should be
free.  The premium service would be the email digest component.  We could also
offer an always fetching feature for premium users.
