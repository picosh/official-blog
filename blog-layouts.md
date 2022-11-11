---
title: New blog layout
description: Experimenting with new layouts
date: 2022-08-27
---

We added the ability to customize your blog index layout.

The first layout that we are releasing is the "aside" layout. It was heavily
inspired by [Drew DeVault's blog](https://drewdevault.com).

[![example aside layout](/aside-layout.png)](https://erock.prose.sh)

Changing your blog index to this layout is easy. All you have to do is edit your
`_readme.md` to add a `layout` frontmatter. Setting it to `aside` will apply the
new layout template.

```md
---
layout: aside
---
```

I'd also like to announce that I would be more than happy to apply patches for
more layouts. I'd also be happy to collaborate on them with anyone who is
interested.

Send all patches and collab requests to
[our mailing list](mailto:~erock/pico.sh@lists.sr.ht).
