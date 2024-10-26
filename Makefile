upload:
	rsync -rv ann/ imgs/ outage/ rfc/ status/ *.md p.prose:/
.PHONY: upload

fmt:
	deno fmt
.PHONY: fmt
