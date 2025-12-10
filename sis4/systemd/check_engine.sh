#!/bin/bash
timestamp=$(date)
echo "$timestamp - Engine health check" >> /var/log/check_engine.log
curl -s http://localhost:8080/health >> /var/log/check_engine.log
echo "" >> /var/log/check_engine.log
