NAME= cloud-1

all: up

up:
	ansible-galaxy install -r ./ansible/requirements.yml
	ansible-playbook -i ./ansible/inventory/inventory.ini ./ansible/playbooks/deploy.yml --ask-vault-pass