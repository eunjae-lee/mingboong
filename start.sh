#!/bin/bash

grunt
grunt watch &
forever start -c coffee app.coffee