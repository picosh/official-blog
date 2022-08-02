---
title: Add tags to your posts!
description: writers can now tag posts for prose and lists
date: 2022-08-02
tags: [feature, announcement]
---

We just launched a new feature for both [prose.sh](https://prose.sh) and
[lists.sh](https://lists.sh) that allows bloggers to add tags to their posts.

## prose.sh

```md
---
title: Tag support launched
description: writers can now tag posts for prose and lists
date: 2022-08-02
tags: [feature, announcement]
---
```

## lists.sh

```
=: title Tag support launched
=: description writers can now tag posts for prose and lists
=: publish_at 2022-08-02
=: tags feature, announcement
```

When tags are added to a post, users can see the tags on a post. When a user
clicks on a tag, it will take them to the writers main blog page, filtering
posts by the tag.

Right now we only support filtering posts by a single tag, but we want to hear
from you if you'd like to filter by multiple tags.

Filtering by tag is also supported for RSS feeds. For example:
[rss?tag=feature](/rss?tag=feature)

This feature was important for us to implement because we are going to leverage
tagging for a new service we are building `imgs.sh` which is a premium image
hosting service. Creating photo albums will created by tagging images. Since we
are implementing it for `imgs.sh` we decided to back port it to `prose.sh` and
`lists.sh`.

We are beginning to bear fruit for our monorepo architecture that we discussed
in our previous [status update post](/status-update-2022-08-01).

## fin

We want to hear from you, so let us know what services or features you think we
should work on next.

Join our [irc #pico.sh on libera](irc://irc.libera.chat/#pico.sh) or email us at
[hello@pico.sh](mailto:hello@pico.sh).

Be sure to subscribe to our [rss feed](/rss) to get the latest updates at team
pico.
