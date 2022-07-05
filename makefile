upload:
	scp -i ~/.ssh/id_ed25519 *.md hey@prose.sh:
.PHONY: upload

upload-local:
	scp -P 2222 *.md hey@localhost:
.PHONY: upload-local

ssh-local:
	ssh -p 2222 hey@localhost
.PHONY: ssh-local

ssh:
	ssh -i ~/.ssh/id_ed25519 hey@prose.sh
.PHONY: ssh
