# emulation-plans
A repository of Mitre Caldera compatible emulation-plans
 
## Background

I wanted to put something together for the community to be able to use, to aid in the sometimes odious task of Adversary Emulation. 

The idea being that the community can build out Emulation Plans and save them in a consistent repository for sharing at a later date. Part of this is ensuring plans are generated in a consistent pattern. To address this; 
- I have created two scripts, one to ensure a reliable and repeatable pattern for developing plans. 
- The second, to deploy plans in a custom `Emulation Plans` Caldera plugin.  
 
Test your SIEM, Test your EDR, don't use this as a way to shame/embarrass your colleagues, you're all on the same team.  

## Quickstart 
> Please read the instructions in this file in full first. Some of the concepts here deviate from other Caldera Plugins. 

If you want to download the Emulation Plans repo, install the plugin and, the APT-28 plan run this: 
```bash
git clone https://github.com/emulation-plans/emulation-plans.git
cd emulation-plans
ruby deployer.rb -n "APT-28" -p "/Users/npalmer/caldera"
```

You will need to login to Caldera and `Enable` the Emulation Plans plugin and then restart before you can use the Adversary/Abilities. 
> You could add the plugin directly into the caldera config file ($CALDERA_DIR/conf/default.yml) and Caldera won't need the aditional restart. 

Further details on the `deployer.rb` and `createplan.rb` scripts are at the bottom of this doc. 
## WTF is going on here?
The directory structure should make sense; 

APT/Group Name, then a Caldera specific named directory. 

- Plans contain a list of APT/Group Names
- Each APT/Group should contain a `README.md` that defines any environment specific pre-requisites etc.
> Please read the `README.md` file in the Group specific directory. It is designed to make running the Emulation Plan in your environment as easy as possible. 
- Abilties contains our abilities split into subdirectories full of tactics, the individual technique is then defined in the YML file.
- Adversaries contain a list of abilities, a friendly name and a brief description. 
- Payloads contain any exe's, dll's or other magic artifacts that we may need to run this adversary as an operation.   
> A note on payloads, they may very well contain malware/bad things. So use at your own risk! The maintainers accept no liability for any damage cause through use of this software 

```
├── README.md
├── createplan.rb
├── deployer.rb
├── emulation-plans
│   └── hook.py
└── plans
    ├── APT-28
    │   ├── README.md
    │   ├── abilities
    │   │   ├── credential-access
    │   │   │   ├── 643fc9ef-1418-4b98-8467-b62c8f2e3b93.yml
    │   │   │   └── d4df3433-4828-4cba-a213-0f2f2ce2e162.yml
    │   │   ├── discovery
    │   │   │   └── 85341c8c-4ecb-4579-8f53-43e3e91d7617.yml
    │   │   ├── execution
    │   │   │   └── af1a51d8-5068-4e46-9035-af27296a8181.yml
    │   │   ├── initial-access
    │   │   │   └── f1ba9455-5a1b-4bbd-9ad4-97cc98b065c2.yml
    │   │   ├── lateral-movement
    │   │   │   └── e42084fc-0a87-4089-90d9-7fb321e17f3b.yml
    │   │   ├── persistence
    │   │   │   └── a4cedb35-5425-4dd8-b95b-22bd42b1b4d8.yml
    │   ├── adversaries
    │   │   └── f5ccb24b-1314-485a-8bfc-234bf7b21760.yml
    │   ├── payloads
    │   │   ├── APT28.dll
    │   │   ├── Rubeus.exe
    │   │   └── passwordlist.txt
    │   └── sources
    │       └── APT-28.yml
...
```

There is a small script `deployer.rb` - this script takes a few values from the user and will then deploy the Plugin, and then any corresponding abilties and adversary files into the plugin's data directory.

```
Usage: deployer.rb [options]
    -h, --help                       Show this help message
    -n, --name NAME                  The name of the APT to install.
    -p, --path PATH                  The path to your $CALDERA/data directory.
```

A second script `createplan.rb` does as the name implies, it allows users to create a skeleton that matches the layout in the markdown above. `$NAME -> ['abilities', 'adversaries', 'payloads'] etc`

```
Usage: createplan.rb [options]
    -h, --help                       Show this help message
    -n, --name NAME                  The name of the APT to create a skeleton for.
``` 
## Props to
Shout out to everyone trying to make InfoSec easier. 
- Mitre for [ATT&CK](https://attack.mitre.org/) and [Caldera](https://github.com/mitre/caldera) obviously. 
- Thanks to Mitre again as for creating the [Center for Threat-Informed Defense](https://github.com/center-for-threat-informed-defense/) which has started building out some very nice emulation plans these can be reviewed [here](https://github.com/center-for-threat-informed-defense/adversary_emulation_library) they are also Apache 2.0 licensed!
    - When I get a chance I will attempt to get FIN6 and APT29 from their repository working in here. 
- Ghostinthewires provided some very interesting Terraform modules that helped to build the labs. You should check out the one on building a domain controller [here](https://github.com/ghostinthewires/terraform-azurerm-ad-create)

 
