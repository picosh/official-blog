---
title: custom css
description: blogs can customize their theme
date: 2022-07-25
tags: [ann]
---

We've heard from a few people that they would like to customize their blog a
little more with their own theme.

It was a simple enough feature to build so I spent an hour or so adding it to
prose.sh.

[git commit](https://git.sr.ht/~erock/prose.sh/commit/24a38b45d0632c6c26e719aa4c77b6acc)

I'm sure we'll get requests to support it in our other services, but for now
we're going to pilot test it here.

All you have to do is create a file `_styles.css` and `scp` it to prose.

```
scp _styles.css <username>@prose.sh:/
```

See [this help section](https://pico.sh/prose#-stylescss) for the full details.

We're excited to see what kind of themes we see in the wild so please feel free
to share it with us at [#pico.sh on libera](https://web.libera.chat/#pico.sh) or
[email us](mailto:hello@prose.sh).
