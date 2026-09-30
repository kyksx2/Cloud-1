# base

Creates the deploy user (`deploy_user`) so the rest of the deployment doesn't run as root.

- adds the user to the `sudo` and `docker` groups
- authorizes `~/.ssh/id_ed25519.pub` for SSH
- passwordless sudo via `/etc/sudoers.d/`

**Requirements:**
root SSH access

**Variables:**
`deploy_user` (group_vars/all.yml)
