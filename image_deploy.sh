#!/bin/bash

git push
ssh karis612@eunjae.net 'cd ~/service/mingboong/ ; git pull ; printf "\n\n\n=====================================\nDeploy Started at %s\n\n" `date +%Y/%m/%d_%H:%M:%S` >> deploy.log; grunt image >> deploy.log'