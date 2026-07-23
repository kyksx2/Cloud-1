NAME= cloud-1

all: up

up:
		ansible-galaxy install -r requirements.yml
		ansible-playbook -i inventory.ini deploy.yml --ask-become-pass