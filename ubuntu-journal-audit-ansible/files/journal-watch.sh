#!/bin/bash
# Monitor journal for high-priority messages and print a summary
journalctl -o json -p err..emerg -n 200 | jq -c '. | {time: .__REALTIME_TIMESTAMP, message: .MESSAGE, unit: ._SYSTEMD_UNIT, priority: .PRIORITY}'
