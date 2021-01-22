# emulation-plans
A repository of Mitre Caldera compatible emulation-plans
 
## Background

I wanted to put something together for the community to be able to use, to aid in the sometimes odious task of Adversary Emulation. 

The idea being that the community (for now, me) can build out Emulation Plans and save them in a consistent repository for sharing at a later date. 

## WTF is going on here?
The directory structure should make sense; 

APT/Group Name, then a Caldera specific named directory. 

- Abilties contains our abilities split into subdirectories full of tactics, the individual technique is then defined in the YML file.
- Adversaries contain a list of abilities, a friendly name and a brief description. 
- Payloads contain any exe's, dll's or other magic artifacts that we may need to run this adversary as an operation.   

```
├── APT-28
│   ├── abilities
│   │   ├── credential-access
│   │   │   └── 643fc9ef-1418-4b98-8467-b62c8f2e3b93.yml
│   │   ├── discovery
│   │   │   ├── 129a7db5-8bc3-498c-8cdc-1aeff166a2df.yml
│   │   │   └── 666c9469-fa3d-4d4c-ab56-2c2ee26ef51a.yml
│   │   ├── execution
│   │   │   ├── af1a51d8-5068-4e46-9035-af27296a8181.yml
│   │   │   ├── d4df3433-4828-4cba-a213-0f2f2ce2e162.yml
│   │   │   └── e42084fc-0a87-4089-90d9-7fb321e17f3b.yml
│   │   └── persistence
│   │       └── a4cedb35-5425-4dd8-b95b-22bd42b1b4d8.yml
│   ├── adversaries
│   │   └── f5ccb24b-1314-485a-8bfc-234bf7b21760.yml
│   └── payloads
│       ├── AdFind.exe
│       ├── Rubeus.exe
│       ├── SEC699.dll
│       └── passwordlist.txt
```

There is a small script `deployer.rb` - this script takes a few values from the user and will then deploy the abilties and adversary file into the Caldera Stockpile plugin's data directory. 

```
Usage: deployer.rb [options]
    -h, --help                       Show this help message
    -n, --name NAME                  The name of the APT to install.
    -p, --path PATH                  The path to your $CALDERA/data directory.

```
 
## Props to
Shout out to everyone trying to make InfoSec easier. 
- Mitre for [ATT&CK](https://attack.mitre.org/) and [Caldera](https://github.com/mitre/caldera) obviously. 
 
