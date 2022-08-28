upload:
	scp *.md imgs/* hey@prose.sh:
.PHONY: upload

upload-local:
	scp -P 2222 *.md imgs/* hey@localhost:
.PHONY: upload-local

ssh-local:
	ssh -p 2222 hey@localhost
.PHONY: ssh-local

ssh:
	ssh hey@prose.sh
.PHONY: ssh
