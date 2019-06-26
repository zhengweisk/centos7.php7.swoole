#!/bin/bash
cd /opt/jiacrontab/server/
nohup ./jiaserver &> /opt/jiacrontab/server.log &
cd /opt/jiacrontab/client/
nohup ./jiaclient &> /opt/jiacrontab/client.log &
tail -f /opt/jiacrontab/server.log
