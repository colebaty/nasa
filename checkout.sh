#!/usr/bin/bash

WORKING_DIR="/home/cole/nasa"
LAST_ACTION=$(tail -n1 $WORKING_DIR/timesheet | awk '{print $8}')

if [[ "$LAST_ACTION" -ne "checkout" ]]; then
    echo "`date` checkout" >> $WORKING_DIR/timesheet
    cat $WORKING_DIR/timesheet
else
    echo "last action was checkout; try checkin"
fi
