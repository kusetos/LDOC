#!/bin/bash
timestamp=$(date +"%Y-%m-%d_%H-%M")
cp /var/log/check_engine.log /var/log/check_engine_$timestamp.log
