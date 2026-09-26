Role Name
=========
install Make, create the folders and update the packages
Copy all inception and the .env crypted by vault.

Role Variables
--------------
Only the name of the user

Author Information
------------------
The file .env need to be in the folder 'files', is encrypt so without my ansible-vault password,
you can't have it.
For security reason, i dont want to push the .env in git even if it's encrypted