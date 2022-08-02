#!/usr/bin/bash

WORKING_DIR="/home/cole/nasa"

datediff() {
    d1=$(date -d "$1" +%s)
    echo "d1: $d1"
    d2=$(date -d "$2" +%s)
    echo "d2: $d2"
    diff=$(( d2 - d1 ))
    echo "diff: $diff"
}

# accepts a difference in epoch seconds as single param
print_time() {
    echo "\$1: $1"
    hours=$(( $1 / 3600 )) # divide to nearest hour
    quarters=$(( ($1 / 900) % 4 )) # to nearest 15 min increments
    minutes=$(( $quarters * 15 ))
    echo "hour(s): $hours minutes: $minutes"
}

begin=$(head -n 1 $WORKING_DIR/timesheet | cut -d' ' -f8 --complement)
end=$(tail -n 1 $WORKING_DIR/timesheet | cut -d' ' -f8 --complement)

datediff "$begin" "$end"
print_time $diff

declare -A checkins
declare -A checkouts
declare -A totals

while read -r line; do
    echo "line: $line"
    action=$(echo $line | cut -d' ' -f8)
    dindex=$(date -d "$(echo $line | cut -d' ' -f8 --complement)" +%Y/%m/%d)
    full_date_epoch=$(date -d "$(echo $line | cut -d' ' -f8 --complement)" +%s)
    if [ "$action" == "checkin" ]; then
        checkins[$dindex]=$full_date_epoch
        echo "adding $dindex to checkins"
        echo ${checkins[$dindex]}
    elif [ "$action" == "checkout" ]; then
        checkouts[$dindex]=$full_date_epoch
        echo "adding $dindex to checkouts"
        echo ${checkins[$dindex]}
    fi
done <<< $(cat $WORKING_DIR/timesheet)

if (( ${#checkins[@]} == ${#checkouts[@]} )); then
    echo "parity"
    for ddate in ${!checkins[@]}; do
        #datediff ${checkins[$ddate]} ${checkouts[$ddate]}
        totals[$ddate]+=$(( ${checkouts[$ddate]} - ${checkins[$ddate]} ))
        print_time ${totals[$ddate]}
    done
elif (( ${#checkouts[@]} == (${#checkins[@]} - 1) )); then
    echo "need to check out"
fi
