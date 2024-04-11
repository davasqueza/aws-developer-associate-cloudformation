#!/bin/bash

sleep 60
aws cloudwatch set-alarm-state --alarm-name "HighCPUAlarm" --state-value ALARM --state-reason "testing purposes"
echo "Good bye!"
