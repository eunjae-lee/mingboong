#!/bin/bash

grunt
pm2 start app.coffee --name mingboong
