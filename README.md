# Forewords
* Tasks fore setup are detailed here.

# Backlog
* [x] Set user password with `passwd`
* [x] Sync Github
* [ ] Aliases
    * [ ] To move Nix config from cloud unto its directory
    * [ ] To edit configs
* [ ] Move all packages to Nix syntax
* [ ] E-mail client - to get notifications on due college assignments
    * [ ] Ensure you have a comment on the config, highlighting this
* [ ] Setup KDE Connect
    * [ ] Add to config: To control Magn when it's connected to tv

=============================================================================================
PENDING

# ================================= LOG
* [x] Add packages through flakes
    * Research on Gemini said the flake.lock looks at the "commit" state of Nixpkgs repo, and which version packages were then... so no modification is needed.
    * Futher explanation, isolation and improvement will be naturally explored and done with time.

# ================================= TO ALIAS
# Sync /etc/nixos/ files to ~/nixos-config
rsync -av --delete /etc/nixos/ ~/nixos-config/
# Sync the files back to /etc/nixos from ~/nixos-config
sudo rsync -av --delete ~/nixos-config/ /etc/nixos/
# Automatically rebuild from the home location (by moving before building) - make it into an alias
sudo rsync -av --delete --exclude '.git' ~/nixos-config/ /etc/nixos/ && sudo nixos-rebuild switch --flake /etc/nixos

=============================================================================================
Documentation

# Tutorial followed
https://nixos-and-flakes.thiscute.world/nixos-with-flakes/nixos-with-flakes-enabled

# Files created requiring backup
> These files, from what I understand, are single files for the whole system, and you must use git in other to control versioning, and backup old ones.
/etc/nixos/flake.nix
/etc/nixos/flake.lock
/etc/nixos/configuration.nix
# Backup but no automated recovery 
/etc/nixos/hardware-configuration.nix

=============================================================================================
Move

# Notes to move
## Concepts/Flakes/Non-system
sudo nixos-rebuild switch --flake /path/to/your/flake#your-hostname
## Concepts/Flakes/Input
Dependencies in inputs has many types and definitions. It can be another flake, a regular Git repository, or a local path. The section Other Usage of Flakes - Flake Inputs describes common types of dependencies and their definitions in detail.
