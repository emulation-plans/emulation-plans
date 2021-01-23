#APT-28

#Introduction
APT-28 is a threat group attributed to Russia. More details can be found [here](https://attack.mitre.org/groups/G0007/). 

#Gotchas
This Emulation plan has been tested in an environment that meets the following cavetas.   

- A domain controller.
- A Windows 10 machine, joined to a domain. 
- A Windows Server 2019 machine, with a service account called `sql_svc` with a password set to: `3g2W31Eo` The `passwordlist.txt` file contains this password. So if you wish to use a different password, make sure you add it to your `passwordlist.txt` file.

 
