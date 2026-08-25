*This project has been created as part of the 42 curriculum by mdodevsk, kjolly.*

# Cloud-1

## Description

Cloud-1 is the automated, cloud-deployed version of the 42 **Inception** project.
Instead of building the Docker stack by hand on a local VM, this repository uses
**Ansible** to provision a remote server end-to-end: install Docker, copy the
project, and bring up the full stack with a single command.

The stack itself follows the Inception requirements:

- **Nginx** — sole entrypoint, TLS only (TLSv1.2/1.3), serves WordPress and
  reverse-proxies phpMyAdmin under `/phpmyadmin/`.
- **WordPress + php-fpm** — built from scratch (Debian base), auto-configured
  and auto-installed on first boot via WP-CLI.
- **MariaDB** — built from scratch, auto-initialized on first boot.
- **phpMyAdmin** — official image, only reachable through the Nginx reverse
  proxy (no exposed port of its own).

Key features:

- One command (`make`) provisions the remote host and deploys the whole stack.
- Idempotent Ansible playbook: safe to re-run, skips redeploying if the stack
  is already up and healthy.
- Persistent data via Docker named volumes bind-mounted to the host
  (`/home/kjolly/data/{mariadb,wordpress}`).
- HTTPS access through a DuckDNS domain.

## Instructions

### Prerequisites

- A remote server (Linux, reachable via SSH as `root` or a sudo-capable user).
- SSH key for that server, referenced in `inventory.ini`.
- `ansible` and `ansible-galaxy` installed on your local/control machine.
- A DuckDNS (or any) domain pointing to the server's IP.
- Docker and Docker Compose are **not** required locally — Ansible installs
  them on the target host.

### Setup

1. **Configure the inventory** — edit `inventory.ini` with the target host,
   SSH user, and private key path:
   ```ini
   [webservers]
   <server-ip> ansible_user=root ansible_ssh_private_key_file=~/.ssh/<key>
   ```

2. **Create the environment file** at `srcs/.env` (not versioned):
   ```env
   DOMAIN_NAME=yourdomain.duckdns.org

   SQL_DATABASE=wordpress
   SQL_USER=wp_user
   SQL_PASSWORD=change_me
   SQL_ROOT_PASSWORD=change_me_too

   WP_TITLE=My WordPress
   WP_ADMIN_USER=admin
   WP_ADMIN_PASSWORD=change_me
   WP_ADMIN_EMAIL=admin@example.com
   WP_USER2_LOGIN=editor
   WP_USER2_EMAIL=editor@example.com
   WP_USER2_PASSWORD=change_me
   ```

3. **Deploy** from the repository root:
   ```bash
   make
   ```
   This installs the required Ansible collections (`requirements.yml`) and
   runs `deploy.yml`, which installs Docker on the target, copies `srcs/` to
   `/var/www/cloud-1/`, and runs `docker compose up -d --build` remotely.

4. **Access the site** at `https://<your-domain>/` and phpMyAdmin at
   `https://<your-domain>/phpmyadmin/`.

### Other commands (run inside `srcs/`)

| Command        | Effect                                             |
|----------------|-----------------------------------------------------|
| `make up`      | Build and start the stack                          |
| `make down`    | Stop the stack (keeps volumes)                     |
| `make restart` | Restart the stack                                  |
| `make logs`    | Tail all container logs                            |
| `make clean`   | Stop stack, remove images/volumes **and host data** |
| `make re`      | `clean` then `up` — full reset                     |
| `make prune`   | Docker system-wide prune (images, volumes)         |

## Resources

- [42 Inception subject](https://cdn.intra.42.fr/pdf/pdf/) (see intranet)
- [Docker documentation](https://docs.docker.com/)
- [Docker Compose file reference](https://docs.docker.com/compose/compose-file/)
- [Ansible documentation](https://docs.ansible.com/)
- [MariaDB installation reference](https://mariadb.com/kb/en/mariadb-install-db/)
- [WP-CLI documentation](https://wp-cli.org/)
- [Nginx documentation](https://nginx.org/en/docs/)
- [DuckDNS](https://www.duckdns.org/)

### AI usage

AI (Claude) was used as a debugging and documentation assistant, not to
generate the project architecture:

- Diagnosing why the MariaDB volume appeared to reset on every deploy
  (permission mismatch between the Ansible-managed host directory and the
  non-root `mysql` user inside the container).
- Reviewing the Ansible playbook for idempotency (avoiding unnecessary
  `changed` states / re-deploys).
- Drafting this README.
