#!/bin/bash
    printf "\n======= Generic Os Info =======\n"
    uname -a
    printf "\n======= Generic User Info =======\n"
    whoami
    printf "\n======= Generic Current Location Info =======\n"
    pwd
       printf "\n======= Generic Hostname Info =======\n"
    hostname
    printf "\n======= Generic Public IP Info =======\n"
    curl ipinfo.io/ip
    printf "\n======= Generic Private IP Info - MACOS=======\n"
    ipconfig getifaddr en0