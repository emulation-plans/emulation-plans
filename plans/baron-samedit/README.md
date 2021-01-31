#Baron Samedit

#Introduction
This is an exploit for the CVE-2021-3156 sudo vulnerability 

#Environment Overview
To make this work you will need    

- A server running: 
  - Ubuntu 18.04.5 (Bionic Beaver) - sudo 1.8.21, libc-2.27
  - Ubuntu 20.04.1 (Focal Fossa) - sudo 1.8.31, libc-2.31
  - Debian 10.0 (Buster) - sudo 1.8.27, libc-2.28
- Egress to the internet
- Git installed

#Emulation Plan overview
- Install Git
- Clone PoC Repo
- Run make to build
- Run exploit with target Zero
> This is set with a static variable. Check your `sources` directory. 

Happy hunting. 
