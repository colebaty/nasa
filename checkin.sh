#!/usr/bin/bash

WORKING_DIR="/home/cole/nasa"
LAST_ACTION=$(tail -n1 $WORKING_DIR/timesheet | awk '{print $8}')

if [[ "$LAST_ACTION" -ne "checkin" ]]; then
    echo "`date` checkin" >> $WORKING_DIR/timesheet
    cat $WORKING_DIR/timesheet
else
    echo "last action was checkin; try checkout"
fi
