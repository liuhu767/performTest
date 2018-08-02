#!/bin/sh
while true
do

cpu1=`adb -s $1 shell cat /proc/stat | awk '{print $2}' |awk 'NR==1{print}'`
cpu2=`adb -s $1 shell cat /proc/stat | awk '{print $3}' |awk 'NR==1{print}'`
cpu3=`adb -s $1 shell cat /proc/stat | awk '{print $4}' |awk 'NR==1{print}'`
cpu4=`adb -s $1 shell cat /proc/stat | awk '{print $5}' |awk 'NR==1{print}'`
cpu5=`adb -s $1 shell cat /proc/stat | awk '{print $6}' |awk 'NR==1{print}'`
cpu6=`adb -s $1 shell cat /proc/stat | awk '{print $7}' |awk 'NR==1{print}'`
cpu7=`adb -s $1 shell cat /proc/stat | awk '{print $8}' |awk 'NR==1{print}'`

totalCpu=`expr $cpu1 + $cpu2 + $cpu3 + $cpu4 + $cpu5 + $cpu6 + $cpu7`
echo totalCpu: $totalCpu

nonIdleCpu=`expr $cpu1 + $cpu2 + $cpu3 + $cpu5 + $cpu6 + $cpu7`
#echo nonIdleCpu: $nonIdleCpu

pidName=`adb -s $1 shell ps | grep $2 | awk '{print $2}' | awk 'NR==1{print}'`

processCpu14=`adb -s $1 shell cat /proc/$pidName/stat | awk '{print $14}'`
processCpu15=`adb -s $1 shell cat /proc/$pidName/stat | awk '{print $15}'`

AppCpu=`expr $processCpu14 + $processCpu15`
echo AppCpu: $AppCpu


sleep 3

cpu12=`adb -s $1 shell cat /proc/stat | awk '{print $2}' |awk 'NR==1{print}'`
cpu22=`adb -s $1 shell cat /proc/stat | awk '{print $3}' |awk 'NR==1{print}'`
cpu32=`adb -s $1 shell cat /proc/stat | awk '{print $4}' |awk 'NR==1{print}'`
cpu42=`adb -s $1 shell cat /proc/stat | awk '{print $5}' |awk 'NR==1{print}'`
cpu52=`adb -s $1 shell cat /proc/stat | awk '{print $6}' |awk 'NR==1{print}'`
cpu62=`adb -s $1 shell cat /proc/stat | awk '{print $7}' |awk 'NR==1{print}'`
cpu72=`adb -s $1 shell cat /proc/stat | awk '{print $8}' |awk 'NR==1{print}'`

totalCpu2=`expr $cpu12 + $cpu22 + $cpu32 + $cpu42 + $cpu52 + $cpu62 + $cpu72`
echo totalCpu2: $totalCpu2

nonIdleCpu2=`expr $cpu12 + $cpu22 + $cpu32 + $cpu52 + $cpu62 + $cpu72`

nonIdleTime=`awk -v x=$nonIdleCpu2 -v y=$nonIdleCpu 'BEGIN{printf "%.4f\n",x-y}'`
totalCpuTime=`awk -v x=$totalCpu2 -v y=$totalCpu 'BEGIN{printf "%.4f\n",x-y}'`

#cpu ratio
totalCpuRatio=`awk -v x=$nonIdleTime -v y=$totalCpuTime 'BEGIN{printf "%.4f\n",x/y}'`
totalCpuRatio2=`awk -v x=$totalCpuRatio -v y=100 'BEGIN{printf "%.2f\n",x*y}'`
echo totalCpuRatio: $totalCpuRatio2

processCpu142=`adb -s $1 shell cat /proc/$pidName/stat | awk '{print $14}'`
processCpu152=`adb -s $1 shell cat /proc/$pidName/stat | awk '{print $15}'`

AppCpu2=`expr $processCpu142 + $processCpu152`
echo AppCpu2: $AppCpu2

processCpuTime=`awk -v x=$AppCpu2 -v y=$AppCpu 'BEGIN{printf "%.4f\n",x-y}'`


appCpuRatio=`awk -v x=$processCpuTime -v y=$totalCpuTime 'BEGIN{printf "%.4f\n",x/y}'`
appCpuRatio2=`awk -v x=$appCpuRatio -v y=100 'BEGIN{printf "%.2f\n",x*y}'`
echo appCpuRatio: $appCpuRatio2
if [[ ${#appCpuRatio2} -ge "0" && ${#appCpuRatio2} -le "100" ]];then
    if [[ ${#totalCpuRatio2} -ge "0" && ${#totalCpuRatio2} -le "100" ]];then
        echo `date +%Y%m%d%H%M%S`'\t'$appCpuRatio2'\t'$totalCpuRatio2 >> cpu.txt
        echo -------------------
    fi
fi

done
