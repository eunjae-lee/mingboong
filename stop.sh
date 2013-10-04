#!/bin/bash

forever stop 0
ps -aef | grep "grunt watch" | awk '{print $2}' | xargs kill -9
