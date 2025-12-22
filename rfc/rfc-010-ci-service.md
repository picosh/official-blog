---
title: rfc-10 a new ci service using docker compose
description: Leveraging docker compose yaml as the spec file for ci
date: 2025-12-21
tags: [rfc]
draft: true
---

|            |                 |
| ---------- | --------------- |
| **status** | draft           |
| **site**   | https://pico.sh |

The most popular CI systems (e.g. gha, gitlab) rely on yaml to create "build manifests" that configure, setup, and run jobs based on external events. Those events most commonly originate from git repos (git-ops) or image registries.

These yaml files enable engineers to construct pipelines to test and deploy their projects. Roughly, pipelines are constructed of stages (groups of jobs) that run in sequence and then within a stage jobs run in parallel.

These pipelines generally include the source repository bash commands, docker containers, and external packages. Since these "build manifests" are yaml files, there's no great way to run them locally. So when initially creating these build manifest, it's common for developers to iteratively "deploy" their manifests until they succeed.

Additionally, since these services do not have a great way to replicate its pipelines locally, it's tedious to understand why a build fails.

The most common CI services also rely on web viewer to monitor the status of pipelines. This requires the developer to jump back-and-forth between their browser and their development IDE/terminals.

As such, we argue that the most popular CI services that exist today are antagonistic to the developer experience.

Instead of reinventing the wheel, we see a way to fix all the rough edges with current CI systems leveraging a tool that most developers are already familiar with: docker compose.

- A pipeline is a list of docker compose files that run in sequence
- A docker compose file contains a list of jobs that run in parallel
