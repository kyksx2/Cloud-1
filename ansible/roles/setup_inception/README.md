# setup_inception

Prepares the project in `/home/<deploy_user>/var/www/cloud-1/`:

- copies `srcs/requirements/` (mariadb, wordpress)
- renders the templates: `docker-compose.yml`, nginx `Dockerfile` and `default.conf`
- copies the `.env`

**Variables:**
`deploy_user`, `domain_name` (group_vars/all.yml)

**Requirements:**
`files/.env` encrypted with ansible-vault. It is not in git, even encrypted: without it (and the vault password) the deployment can't run. See `srcs/.env.exemple` for the expected keys.
