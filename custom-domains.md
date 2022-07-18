---
title: Custom domains
description: it's as easy as a DNS entry
date: 2022-07-18
---

It's been a pretty exciting week for us at the pico.sh headquarters.

We made it to the front-page of [hackernews](https://news.ycombinator.com/item?id=32128013)!

![front-page of hacker news](https://pbs.twimg.com/media/FX9masGXoAAbbuA?format=jpg&name=large
"front-page of hackernews")

We were so excited about the launched that we announced in the thread support
for custom domains landed.

We figured it would be a good idea to officially announce it on our blog.

## Add your custom domain today!

Don't want to be bored with the details of how custom domains work?

The full usage guide can be found on our [help
page](https://prose.sh/help#custom-domain).

## How it works

We decided to go with a solution that didn't require us to store any
information about the custom domain you want to use.  Instead, all the user
needs to do is add a `TXT` record with `prose=<username>` and then point the
domain with a `CNAME` to `prose.sh`.

Under the hood we use [Caddy's on-demand
tls](https://caddyserver.com/docs/automatic-https#on-demand-tls).  On our end,
the configuration was very simple using `Caddyfile`:

```
{
	on_demand_tls {
		ask http://web:3000/check
		interval 1m
		burst 10
	}
}

:443 {
	reverse_proxy web:3000
	tls hello@prose.sh {
		on_demand
	}
	encode zstd gzip
}
```

The endpoint referenced in the above Caddyfile points to this golang function:

```go
func checkHandler(w http.ResponseWriter, r *http.Request) {
	dbpool := GetDB(r)
	cfg := GetCfg(r)

	if cfg.IsCustomdomains() {
		hostDomain := r.URL.Query().Get("domain")
		appDomain := strings.Split(cfg.ConfigCms.Domain, ":")[0]

		if !strings.Contains(hostDomain, appDomain) {
			subdomain := GetCustomDomain(hostDomain)
			if subdomain != "" {
				u, err := dbpool.FindUserForName(subdomain)
				if u != nil && err == nil {
					w.WriteHeader(http.StatusOK)
					return
				}
			}
		}
	}

	w.WriteHeader(http.StatusNotFound)
}
```

This function does a couple of things.  It gets the current domain from the
request and then performs a `TXT` lookup via `GetCustomDomain`:

```go
func GetCustomDomain(host string) string {
	records, err := net.LookupTXT(fmt.Sprintf("_prose.%s", host))
	if err != nil {
		return ""
	}

	for _, v := range records {
		return strings.TrimSpace(v)
	}

	return ""
}
```

If the username matches then we respond with a success status.  That's really
all there is to it.  

It's amazing how far we've come with TLS, isn't it?

## Wrap up

This is just one of many features we have planned to make prose.sh awesome.  We
also have a handful of [sibling services](https://todo.sr.ht/~erock/pico.sh?search=status%3Aopen%20label%3A%22service%22) 
we are thinking about building.

Have any suggestions about this service or what we are working on?  Join us at
[#pico.sh on libera](irc://irc.libera.chat/#pico.sh) or send us an email at [hello@pico.sh](mailto:hello@pico.sh).

Also don't forget to subscribe to this [RSS feed](https://hey.prose.sh/rss) to receive all the latest
updates.
