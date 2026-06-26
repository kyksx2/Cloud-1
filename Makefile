NAME: cloud-1

all: up

up:
	ansible-playbook -i inventory.ini deploy.yml --ask-become-pass