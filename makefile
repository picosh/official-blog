upload:
	scp *.md imgs/* p.prose:/
.PHONY: upload

fmt:
	deno fmt
.PHONY: fmt
