#!/bin/bash


# Update the OS
sudo apt-get update
sudo apt-get upgrade -y


# Install SteamCMD, these echos are to avoid the nag screen on install
echo steamcmd steam/question select 'I AGREE' | debconf-set-selections
echo steamcmd steam/license  note   ''        | debconf-set-selections
echo steamcmd steam/purge    note   ''        | debconf-set-selections
sudo apt-get install steamcmd -y


# Set up the underlying service account for steam
sudo useradd -m -s /bin/bash steam


# Script to initialize/update the server
cat << EOF >> /usr/local/bin/valheim.sh
#!/bin/bash
export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/home/steam/valheim/linux64:$LD_LIBRARY_PATH
export SteamAppId=892970

/home/steam/valheim/valheim_server.x86_64 -name "${server_name}" -port 2456 -world "${world_name}" -password "${password}"
export LD_LIBRARY_PATH=$templdpath
EOF

chmod +x /usr/local/bin/valheim.sh


# Create the service
cat << EOF >> /etc/systemd/system/valheim.service
[Unit]
Description=Valheim

[Service]
Type=simple
User=steam
ExecStartPre=/usr/games/steamcmd +login anonymous +force_install_dir /home/steam/valheim +app_update 896660 validate +exit
ExecStart=/bin/bash /usr/local/bin/valheim.sh
TimeoutSec=300

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable valheim
sudo reboot
