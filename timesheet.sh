#!/usr/bin/bash

# automatically log checkin/out to a timesheet
# if no timesheet present 
#   create one and 
#   check in immediately
# else 
#   create new log entry based on last logged action

WORKING_DIR="/home/cole/nasa"
LAST_ACTION=""

# test for timesheet
if [ ! -f $WORKING_DIR/timesheet ]; then
    echo "no timesheet found; creating timesheet"
    touch $WORKING_DIR/timesheet
    LAST_ACTION="checkout"
else
    LAST_ACTION=$(tail -n1 $WORKING_DIR/timesheet | cut -d' ' -f 8)
fi

# echo "LAST_ACTION: $LAST_ACTION"

if [ "$LAST_ACTION" == "checkin" ]; then
    # echo "checking out"
    echo "`date` checkout" >> $WORKING_DIR/timesheet
elif [ "$LAST_ACTION" == "checkout" ]; then
    # echo "checking in"
    echo "`date` checkin" >> $WORKING_DIR/timesheet
else
    echo "error: unable to complete task, try again"
fi

tail -n 10 $WORKING_DIR/timesheet

# TODO:
# - breakdown of hours worked per day
