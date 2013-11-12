#!/bin/bash

grunt
grunt watch &
forever --pidFile "${PWD}/app.pid" start -c coffee app.coffee