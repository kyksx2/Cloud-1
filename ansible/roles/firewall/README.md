# firewall

Configures `ufw`: only ports 22 (SSH), 80 (HTTP) and 443 (HTTPS) are open, all other incoming traffic is denied.

**Requirements:**
root/sudo, collection `community.general`

**Note:**
Docker bypasses ufw for ports published in the compose `ports:` → only 80 and 443 are published there.
