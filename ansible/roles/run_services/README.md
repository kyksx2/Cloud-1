# run_services

Starts the stack with `docker compose` (builds missing images only).

**Requirements:**
roles `base`, `install_docker` and `setup_inception` run before.

**Note:**
a changed nginx template doesn't rebuild the existing image you have to `make clean` or `docker compose up -d --build nginx`.
