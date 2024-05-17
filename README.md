# Quick Quarm EQ
<h3>About</h3>
<p>Are you a player on Secret's Project Quarm Everquest server?  Have you ever wanted to load up your own PQ server for personal use or to play with friends?  Are you a developer in the PQ universe and want to test out patches, make game changes, or just verify mechanics?  It sounds like Quick Quarm might be the tool for you.
<p>If you are like me, I wanted to get a server up and running and tried several different approaches that all lead to dead ends.  The EQEmu server install guide noted in our PQ repo worked, and the interface is beautiful, but it's not compatible with PQ.  
<p>EQMacDocker worked great, install went smooth, but I noticed several things that didn't work for me as a developer.  
<p>First, the entire docker based system added a tremendous amount of overhead whenever I made a minor code change.  Rebuilding all of the docker images means starting from scratch and this was extremely time consuming and resource wasteful.  <ins>Quick Quarm only rebuilds the affected parts of the code</ins>.  
<p>Second, I wanted a system I could stop and start services easily after making changes.  With docker, there's atomic processes running in containers that have to be managed discretely instead of using systemd to control service dependencies.  The current implementation of docker containers causes race conditions where dependencies are not considered correctly leading to stalled server starting.  <ins>Quick Quarm performs host control over properly ordered service starts from a unified systemd process</ins>.  
<p>Third, the docker solution as presented is not started on server up and is launched as an interactive process in the foreground.  It could be configured to detach and start on system start, but that's up the user to figure out.  <ins>Quick Quarm starts when the server starts automatically in the background</ins>.  
<p>Quick Quarm does require that you have a persistent host, but you would need that to run the docker daemon anyway.  I think this solution fits the needs of most moderately tech capable people who just want a quick Quarm server to play or seasoned developers who want to dive into the code and give back to the community.

<h3>Notes</h3>


<h3>Instructions</h3>
<ul>
  <li>Create an Ubuntu 22.04 LTS WSL2, VM or persistent container (such as LXC).  <i>[have not tested other OSs]</i>
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
   [INSTALL] Upgrading system...
   [INSTALL] Installing dependencies...
   [INSTALL] Setting up MySQL user...
    [SOURCE] Cloning Server repo...
    [SOURCE] Cloning quests repo...
    [SOURCE] Cloning maps repo...
  [DATABASE] Extracting latest database files...
  [DATABASE] Setup database and tables...
     [MYSQL] Importing: quarm < /home/rhoneyman/quick-quarm/db/login_tables_*.sql
     [MYSQL] Importing: quarm < /home/rhoneyman/quick-quarm/db/player_tables_*.sql
     [MYSQL] Importing: quarm < /home/rhoneyman/quick-quarm/db/quarm_*.sql
     [MYSQL] Importing: quarm < /home/rhoneyman/quick-quarm/db/data_tables_*.sql
     [MYSQL] Importing: quarm < /home/rhoneyman/quick-quarm/source/EQMacEmu/loginserver/login_util/tblloginserversettings.sql
     [MYSQL] Importing: quarm < /home/rhoneyman/quick-quarm/source/EQMacEmu/loginserver/login_util/updates/2023_07_27_tblLoginServerAccounts.sql
     [MYSQL] Importing: quarm < /home/rhoneyman/quick-quarm/files/update_settings.sql
     [BUILD] Generating make files...
     [BUILD] Starting build with 2 threads... (this may take some time for the initial build)
   [INSTALL] Cleaning up bin directory
   [INSTALL] Copy build binaries to bin directory
   [INSTALL] Create logs and shared directories
   [INSTALL] Link quests and maps directories
   [INSTALL] Copy in auxillary configuration files
    [CONFIG] Updating eqemu_config.json
    [CONFIG] Updating login.ini
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

 * New users: Download the TAKP v2.2 Client and the associated PQ package zip file from PQ Discord #server-files
 * Existing users: Copy your existing TAKP folder to another separate folder from your normal PQ install.
 * Edit the file eqhost.txt file and change loginserver.takproject.net:6000 to 192.168.1.100:6000
 * Start your client (run as Administrator, and set compatibility options if needed)
 * Login as whatever username/password you want to use (this will fail and is expected).  Click Ok, and hit [ENTER] again.
 * You should see your Quick Quarm EQ server in the list: select it, create a character, and enter the world.
 * On your Quick Quarm host, run ./scripts/eq-makegm -l LOGINACCOUNT
 * If you are already logged in, enter '/sit', '/camp login', then log back in to activate GM powers.
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

<h3>Setup Flags</h3>
<pre>
./setup
        -d      Enable debug
        -v      Enable verbose logging
        -f      Enable forced commands (disregard any safety checks) <b>[not currently used]</b>
        -c      Enable clean mode (removes database/source and starts clean)
        -h      This help
</pre>