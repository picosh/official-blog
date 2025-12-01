upload:
	rsync -rv ann/ imgs/ outage/ rfc/ status/ *.md p.prose:/
.PHONY: upload

fmt:
	uvx --with=mdformat-gfm --with=mdformat-frontmatter mdformat **/*.md
.PHONY: fmt
