#!/bin/bash

git push
ssh karis612@eunjae.net 'cd ~/service/mingboong/ ; git pull ; grunt image'