---
title: lists.sh shutdown notice
date: 2024-01-20
tags: [announcement]
description: lists.sh will shutdown on 2024-07-20
---

We are shutting down **lists.sh**. We want to build and maintain services we
ourselves use. As we have been thinking about lists over the year we have found
ourselves rarely using the service.

We are also seeing really low usage rates and ultimately we feel like it's time
to shut it down.

# Roadmap

Lists will be read-only effective immediately. Users will still be able to
download their lists using any of our
[supported tools for downloading files](https://pico/file-uploads).

```bash
sftp <user>@lists.sh
> get * .
```

> **2024-07-20** we will shutdown all services for lists.

We think this is an adequate migration window for lists.

Feel free to reach out if you have questions, we are happy to help!
