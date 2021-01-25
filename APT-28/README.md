#APT-28

#Introduction
APT-28 is a threat group attributed to Russia. More details can be found [here](https://attack.mitre.org/groups/G0007/). 

#Gotchas
This Emulation plan has been tested in an environment that meets the following cavetas.   

- A domain controller.
- A Windows 10 machine, joined to a domain. 
- A Windows Server 2019 machine, with a service account called `sql_svc` with a password set to: `3g2W31Eo` The `passwordlist.txt` file contains this password. So if you wish to use a different password, make sure you add it to your `passwordlist.txt` file.
- A C2 Server - The _Run Rubeus to brute-force password from ticket_ ability (Credential Access - T1208) needs to pull the Rubeus and Passwordlist files from it. This can be any C2 Server (Covenant/Cobalt Strike etc) as long as you can present files for download of HTTP. Simply update the file `643fc9ef-1418-4b98-8467-b62c8f2e3b93.yml` with the IP and Port of the download URL. 

 
