#APT-28

#Introduction
APT-28 is a threat group attributed to Russia. More details can be found [here](https://attack.mitre.org/groups/G0007/). 

#Environment Overview
This Emulation plan has been tested in an environment that meets the following cavetas.   

- A domain controller.
- A Windows 10 machine, joined to a domain. 
- A Windows Server 2019 machine, with a service account called `sql_svc` with a password set to: `3g2W31Eo` The `passwordlist.txt` file contains this password. So if you wish to use a different password, make sure you add it to your `passwordlist.txt` file.
- A C2 Server - The _Run Rubeus to brute-force password from ticket_ ability (Credential Access - T1208) needs to pull the Rubeus and Passwordlist files from it. This can be any C2 Server (Covenant/Cobalt Strike etc) as long as you can present files for download of HTTP. Simply update the file `643fc9ef-1418-4b98-8467-b62c8f2e3b93.yml` with the IP and Port of the download URL. 

#Adapting to your own needs 

Utilise the sources directory and corresponding $PLAN.yml file to set facts for TTPs to use, in order to work with your environment better. For example:

One could change the `e42084fc-0a87-4089-90d9-7fb321e17f3b.yml` ability, to leverage a defined fact, instead of a learned fact. 

```yaml
[truncated]
$password = ConvertTo-SecureString "#{host.user.password}" -AsPlainText -Force; $credentials = New-Object System.Management.Automation.PSCredential("$env:USERDNSDOMAIN\#{host.user.name}", $password); 
[truncated]
```
Could become something like: 
```yaml
[truncated]
$password = ConvertTo-SecureString "#{host.user.password}" -AsPlainText -Force; $credentials = New-Object System.Management.Automation.PSCredential("$env:USERDNSDOMAIN\#{remote.sql.user.name}", $password);
[truncated] 
```
Or you may want to use a specific host in the Lateral Movement ability. You would do something like this: 

Before
```yaml
[truncated]
... Invoke-WmiMethod -Path win32_process -Name create -ComputerName "#{host.ip.address}" -Credential $credentials -ArgumentList ...
[truncated]
```
After
```yaml
[truncated]
... Invoke-WmiMethod -Path win32_process -Name create -ComputerName "#{sql.server.ip}" -Credential $credentials -ArgumentList ...
[truncated]
```

Where the corresponding ./sources/APT-28.yml file is configured to look like the following

```yaml
---
id: apt-28
name: apt-28-predefined
facts:
  - trait: remote.sql.user.name
    value: sql_svc
  - trait: sql.server.ip
    value: 192.168.20.104
```

