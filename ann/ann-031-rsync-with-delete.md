---
title: rsync with delete
description: the pico platform now supports rsync delete
date: 2025-02-27
tags: [ann]
---

Greetings!

Quick update, we recently added support for `rsync --delete`. This has been a highly requested feature and we are excited that we can improve workflows for users.

All services that support [file uploads](https://pico.sh/file-uploads) now support `rsync --delete`.

In particular we think this will help users manage their static sites better. Previously, if you wanted to delete old static files from a site, you'd need to either **a)** explicitly delete the files, **b)** create a new project for every deployment and use symbolic linking. For projects that want instant promotion/rollback support, symbolic linking solves the problem. However, we know there are a bunch of projects that don't need that feature and want something lighter-weight to keep their sites in sync.

Why was `--delete` so difficult to implement on the pico platform? While users can use the `rsync` client that they already have installed on their system, we have to reimplement the rsync server in order for it to work within pico. So every flag and feature of rsync has to be reimplemented in our go services. This has proven to be rather difficult and time consuming.
