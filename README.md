# Quick Quarm EQ
<h3>Instructions</h3>
<ul>
  <li>Create an Ubuntu 22.04 LTS VM or container.
  <li>Install with any user that has sudo privilege.
  <li>Clone this repo to the directory of your choosing: <b>git clone https://github.com/ryhoneyman/quick-quarm.git</b>
  <li>Change to the quick-quarm repo directory and run sudo ./scripts/setup
</ul>

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
