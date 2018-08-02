#!/bin/sh
while true
do
    sleep 10
#echo $1:5555
    NativeMemo=`adb -s $1 shell dumpsys meminfo $2 | grep Native | awk '{print $3}' | awk 'NR==1{print}'`
echo NativeMemo:$NativeMemo

    DalvikMemo=`adb -s $1 shell dumpsys meminfo $2 | grep Dalvik |grep Heap | awk '{print $3}'`
echo DalvikMemo:$DalvikMemo

    TotalMemo=`adb -s $1 shell dumpsys meminfo $2 | grep TOTAL| awk '{print $2}'`
    if [[ ${#TotalMemo} < 2 ]];then
        TotalMemo=`adb -s $1 shell dumpsys meminfo $2 | grep TOTAL: |awk '{print $2}'`
    fi
echo TotalMemo:$TotalMemo
echo --------------------
echo `date +%Y%m%d%H%M%S`'\t'$NativeMemo'\t'$DalvikMemo'\t'$TotalMemo >> /Users/liuhu02/Desktop/mem.txt

done


