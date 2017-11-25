DigitalOcean Auto Snapshot Volume
=================================

# What does this script do ?
Since DigitalOcean currently didn't provide auto backup for the volume. So, i created the script to call DigitalOcean API and creating volume's snapshot. After successfully created, it will delete the old snapshot.

# How to use?
1. Download `jq` (https://stedolan.github.io/jq/) and install to your `/usr/local/bin/jq`.
2. Config your parameter in `auto-snapshot.sh`
3. Set cronjob to execute `auto-snapshot.sh`