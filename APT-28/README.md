#APT-28

#Introduction
APT-28 is a threat group attributed to Russia. More details can be found [here](https://attack.mitre.org/groups/G0007/). 

#Environment Overview
This Emulation plan has been tested in an environment that meets the following cavetas.   

- A domain controller.
- A Windows 10 machine, joined to a domain. 
- A Windows Server 2019 machine, with a service account called `sql_svc` with a password set to: `3g2W31Eo` The `passwordlist.txt` file contains this password. So if you wish to use a different password, make sure you add it to your `passwordlist.txt` file.
- A C2 Server - The _Run Rubeus to brute-force password from ticket_ ability (Credential Access - T1208) needs to pull the Rubeus and Passwordlist files from it. This can be any C2 Server (Covenant/Cobalt Strike etc) as long as you can present files for download of HTTP. Simply update the file `643fc9ef-1418-4b98-8467-b62c8f2e3b93.yml` with the IP and Port of the download URL. 

#Emulation Plan overview

The plan should run like this; 

- Step 1 is a simple `persistence` exercise - can we use Task Scheduler to persist an artifact on the machine. In our instance, our artifact is a Scheduled Task containing a link to Rick Astley's 'Never Gonna Give You Up'
    - We can validate that the task has worked by running `Get-ScheduledTask -TaskName "NeverGonna"` from a PowerShell prompt. 
- Step 2 leverages `Rundll32` and a custom `APT28.dll` this DLL, when executed runs creates a text file and will output a small message and timestamp. 
    - Validation step, confirm existance of the `C:/Users/Public/APT28.txt` file and confirm it's contents look simmilar to: `APT28: Payload executed on Tue Jan 26 10:28:41 2021`
- Step 3 invokes Rubeus (which is provided in the `./payload` directory) and attempts to perform Kerberoasting on the local machine. 
- Step 4 `arp` is run to then locate other machines to connect with
    - Your SIEM/EDR should show a log that `arp` has been run.
- Step 5 Use the username we found in Step 3 and attempt to bruteforce it's password with the provided `passwordlist.txt` and `Rubeus`  
- Step 6 this is the exciting part; here the attacker is attempting to use their recently acquired credentials to laterally move around our environment. This is done with WMI. 
    - Validate this by checking your SIEM/EDR/Networking Monitoring tools for suspicious processes (such as `WmiPrvSE.exe`) talking across the network, particularly using high ports.  
     
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

