# Quick Quarm EQ
<h3>Instructions</h3>
<ul>
  <li>Create an Ubuntu 22.04 LTS VM or container.
  <li>Install with any user that has sudo privilege.
  <li>Clone this repo to the directory of your choosing: <b>git clone https://github.com/ryhoneyman/quick-quarm.git</b>
  <li>Change to the quick-quarm repo directory and run <b>sudo ./scripts/setup</b>
</ul>

<h4>Configuration</h4>
<pre>
user@host:~/quick-quarm$ sudo ./scripts/setup

Detected /home/user/quick-quarm as Quick Quarm home (user: user)

The defaults are a great starting point, so it's safe to accept them as is to get up and running.
However, if you have a cloned repo of SecretsOTheP/EQMacEmu that you are using for development, feel free to use that instead.

If you are using your own repo, make sure you've setup your git SSH key, and git username/email BEFORE continuing.

Install user [user]:
EQMacEmu repository [https://github.com/SecretsOTheP/EQMacEmu.git]:
Database host [localhost]:
Database name [quarm]:
Database username [quarm]:
Database password [quarm]:
Host address [192.168.1.100]:

Writing configuration to /home/user/quick-quarm/etc/.env
</pre>

<h4>Setup</h4>
<pre>
Beginning setup:
 [INSTALL] Updating system...
     [CMD] Running: /usr/bin/apt-get update (as root)
 [INSTALL] Upgrading system...
     [CMD] Running: /usr/bin/apt-get -y upgrade (as root)
 [INSTALL] Installing dependencies...
     [CMD] Running: /usr/bin/apt-get -y install git build-essential cmake libboost-dev libmariadb-dev liblua5.1-dev uuid-dev mariadb-server (as root)
 [INSTALL] Setting up MySQL user...
   [MYSQL] Executing: DROP USER IF EXISTS 'quarm'@'%'; CREATE USER 'quarm'@'%' IDENTIFIED BY 'quarm'; GRANT ALL ON quarm.* TO 'quarm'@'%' (as root)
  [SOURCE] Cloning Server repo...
     [CMD] Running: git clone https://github.com/SecretsOTheP/EQMacEmu.git EQMacEmu 2>/dev/null (as user)
  [SOURCE] Cloning quests repo...
     [CMD] Running: git clone https://github.com/SecretsOTheP/quests.git quests 2>/dev/null (as user)
  [SOURCE] Cloning maps repo...
     [CMD] Running: git clone https://github.com/EQMacEmu/Maps.git Maps 2>/dev/null (as user)
[DATABASE] Extracting latest database files...
     [CMD] Running: tar zxf /home/user/quick-quarm/source/EQMacEmu/utils/sql/database_full/quarm_2024-04-15-22_51.tar.gz (as user)
[DATABASE] Setup database and tables...
   [MYSQL] Executing: DROP DATABASE IF EXISTS quarm; CREATE DATABASE quarm (as root)
   [MYSQL] Importing: quarm < /home/user/quick-quarm/db/login_tables_*.sql
   [MYSQL] Importing: quarm < /home/user/quick-quarm/db/player_tables_*.sql
   [MYSQL] Importing: quarm < /home/user/quick-quarm/db/quarm_*.sql
   [MYSQL] Importing: quarm < /home/user/quick-quarm/db/data_tables_*.sql
   [MYSQL] Importing: quarm < /home/user/quick-quarm/source/EQMacEmu/loginserver/login_util/tblloginserversettings.sql
   [MYSQL] Importing: quarm < /home/user/quick-quarm/source/EQMacEmu/loginserver/login_util/updates/2023_07_27_tblLoginServerAccounts.sql
   [MYSQL] Importing: quarm < /home/user/quick-quarm/files/update_settings.sql
   [BUILD] Generating make files...
     [CMD] Running: cmake -DCMAKE_CXX_FLAGS='-w -fcompare-debug-second' -G 'Unix Makefiles' . (as user)
   [BUILD] Starting build with 2 threads... (this may take some time for the initial build)
     [CMD] Running: make -j2 (as user)
 [INSTALL] Cleaning up bin directory
     [CMD] Running: find /home/user/quick-quarm/bin -type f ! -name .gitkeep -delete (as user)
 [INSTALL] Copy build binaries to bin directory
     [CMD] Running: cp ../source/EQMacEmu/bin/* . (as user)
 [INSTALL] Create logs and shared directories
     [CMD] Running: mkdir -p logs (as user)
     [CMD] Running: mkdir -p shared (as user)
 [INSTALL] Link quests and maps directories
     [CMD] Running: ln -fs ../source/Maps (as user)
     [CMD] Running: ln -fs ../source/quests (as user)
 [INSTALL] Copy in auxillary configuration files
     [CMD] Running: cp ../source/EQMacEmu/loginserver/login_util/*.conf . (as user)
     [CMD] Running: cp ../source/EQMacEmu/utils/patches/*.conf . (as user)
  [CONFIG] Updating eqemu_config.json
     [CMD] Running: envsubst < /home/user/quick-quarm/files/eqemu_config.json.tmpl > /home/user/quick-quarm/bin/eqemu_config.json (as user)
  [CONFIG] Updating login.ini
     [CMD] Running: envsubst < /home/user/quick-quarm/files/login.ini.tmpl > /home/user/quick-quarm/bin/login.ini (as user)
 [SYSTEMD] Installing Quick Quarm service
 [SYSTEMD] Service eqemu-loginserver.service installing...
 [SYSTEMD] Service eqemu-queryserv.service installing...
 [SYSTEMD] Service eqemu-shared-memory.service installing...
 [SYSTEMD] Service eqemu-ucs.service installing...
 [SYSTEMD] Service eqemu-world.service installing...
 [SYSTEMD] Service eqemu-zone.service installing...
 [SYSTEMD] Service quick-quarm.target installing...
 [SYSTEMD] Enabling Quick Quarm service


===== DONE!!! =====

Congratulations! Everything completed successfully, and you're one step closer to your own Quarm server.

Next Steps:

 * Download the TAKP v2.2 Client (or copy your existing TAKP folder) to another separate folder from your production Quarm install (if present).
 * Edit the file eqhost.txt file and change loginserver.takproject.net:6000 to 192.168.1.100:6000
 * Start your client (run as Administrator)
 * Login as whatever username/password you want to use (this will fail and is expected).  Just immediately hit [ENTER] again.
 * You should see your Quick Quarm EQ server in the list: select it, create a character, and enter the world.
 * Your user is not flagged as a GM.  Run /home/user/quick-quarm/scripts/eq-makegm -l LOGINACCOUNT then type '/sit' and '/camp login' to activate.
</pre>

<h3>What It Does</h3>
<ul>
  <li>Updates the system and install all Project Quarm dependencies
  <li>Downloads source from git repos
  <li>Installs the Project Quarm database and sets up user/permissions
  <li>Builds and installs the Project Quarm source code into binaries
  <li>Updates all configuration files for this specific installation
  <li>Installs quick-quarm.target service into systemd and enables it on boot.
</ul>

<h3>Updating</h3>
In order to update Project Quarm to the latest source and database, from the quick-quarm repo directory just run:
<ul>
  <li><b>./scripts/update</b>
  <li><b>sudo systemctl restart quick-quarm.target</b> (server will come down and restart)
</ul>
