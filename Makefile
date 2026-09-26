NAME= cloud-1

all: up

up:
	ansible-galaxy install -r ./ansible/requirements.yml
	ansible-playbook ./ansible/playbooks/deploy.yml --ask-vault-pass

clean:
	ansible-playbook ./ansible/playbooks/clean.yml