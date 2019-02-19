# performTest
性能测试知识总结

一、Android手机上的总体CPU使用率的计算方法：
1.确保手机连接上电脑

2.执行adb shell cat  /proc/stat 命令，得到如下内容：

cpu  2015245 31052 995895 9938789 20475 747 162015 0 0 0
cpu0 893242 11794 500592 4733353 10980 646 107531 0 0 0
cpu1 445888 4186 136991 411738 1410 5 9647 0 0 0
cpu2 72813 2423 25549 157850 901 0 1385 0 0 0
cpu3 603302 12649 332763 4635848 7184 96 43452 0 0 0
intr 64643438 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 14483288 0 0 0 0 0 0 0 0 0 0 0 0 0 561801 0 0 0 0 0 0 4018546 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 5946 8 5 0 10 0 0 0 1923979 0 0 0 0 0 0 0 0 0 0 42495 0 0 0 0 2 106 2 0 2 0 0 0 2 2 0 0 0 0 0 0 0 0 0 0 0 0 0 1110185 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 35559 960575 0 0 0 0 0 0 0 880 9838812 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 643208 0 13 0 0 0 0 0 883283 0 0 0 0 0 0 3 0 0 0 499889 5 0 1785951 2014490 0 0 0 0 0 0 0 0 0 462439 0 7 0 0 0 0 1126 350 0 0 0 2783614 0 0 223128 0 0 0 0 0 0 0 0 0 0 0 0 438 0 0 0 0 0 126465 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1357385 0 0 0 0 0 0 0 0 0 0 0 0 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 8 0 0 0 0 0 0 7 0 0 0 0 0 0 0 0 0 6 0 0 0 0 13 1 0 0 0 0 0 0 0 0 0 0 0 0 0 6 4 0 0 0 0 0 126401 0 0 8 8 0 0 0 0 5265 633 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 8 0 0 1351494 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
ctxt 163763406
btime 1533126197
processes 110689
procs_running 4
procs_blocked 0
softirq 27323080 11396 4950708 21296 616408 8287 8287 428051 5639295 15585 15623767

这个手机为4核的，如果是8核，则显示从cpu0到cpu7的数据。

现在分析第一行：从第一行的第二列到第八列代表的意思如下：
user：从系统启动开始累计到当前时刻，用户态的CPU时间（单位：jiffies） ，不包含 nice值为负进程。1jiffies=0.01秒
nice ： 从系统启动开始累计到当前时刻，nice值为负的进程所占用的CPU时间（单位：jiffies）
system ：从系统启动开始累计到当前时刻，核心时间（单位：jiffies）
idle ：从系统启动开始累计到当前时刻，除硬盘IO等待时间以外其它等待时间（单位：jiffies）
iowait ：从系统启动开始累计到当前时刻，硬盘IO等待时间（单位：jiffies） ，
irq ： 从系统启动开始累计到当前时刻，硬中断时间（单位：jiffies）
softirq ：从系统启动开始累计到当前时刻，软中断时间（单位：jiffies）



totalCpuTime=user+nice+system+idle+iowait+irq+softirq



计算瞬时的CPU使用率：
CPU总使用率（%） =  100*(totalCpuTime - idle)/totalCpuTime

 

计算两个时间点之间的CPU使用率：
先取两个采样点，然后计算其差值：

CPU总使用率（%） =  100*((totalCpuTime2- totalCpuTime1)-(idle2-idle1))/(totalCpuTime2-totalCpuTime1) 



二、Android手机上单独APP的CPU使用率计算方法：
1.确保手机连接上电脑

2.根据adb shell ps | grep 包名，得到待测试APP的pid：
如果是windows电脑，查询包名是findstr，内容如下：
adb shell ps | grep com.xxxxxx
u0_a344   21828 345   1077816 148328 sys_epoll_ 00000000 S com.xxxxxx
此时pid为21828。

3.执行adb shell cat /proc/pid/stat，得到如下内容：
21828 (runTaskSync) S 345 345 0 0 -1 4194624 5404266 0 40 0 48565 29943 0 0 10 -10 67 0 724923 
1103822848 37057 4294967295 1 1 0 0 0 0 4612 0 38136 4294967295 0 0 17 3 0 0 0 0 0 0 0 0

现在分析第一行：以下只解释对我们计算Cpu使用率有用相关参数：
 

位置           参数                          解释


第一列  ：pid=21828                         进程号

第十四列：utime=48565                       该任务在用户态运行的时间，单位为jiffies

第十五列：stime=29943                       该任务在核心态运行的时间，单位为jiffies

第十六列：cutime=0                          所有已死线程在用户态运行的时间，单位为jiffies

第十七列：cstime=0                          所有已死在核心态运行的时间，单位为jiffies


processCpuTime = utime + stime + cutime + cstime

 
计算瞬时的CPU使用率：
单个程序CPU使用率（%）：processCpuRatio = 100 * processCpuTime  / totalCpuTime


计算两个时间点之间的CPU使用率：
 
先取两个采样点，然后计算其差值：

单个程序的CPU使用率（%） processCpuRatio = 100*(processCpuTime2-processCpuTime1)/(totalCpuTime2-totalCpuTime1) 
 

问1：为什么不用top?

top也是通过查询/proc目录得到的数据，top的优点就是获取信息简单容易。使用此方法的缺点也一目了然，就是精确度不是很高

在不同的手机上，top命令的输出结构可能会不同，有时候并不是第三列

 

问2：为什么不用dump cpuinfo?

top分母是CPU jiffies，而dump cpuinfo是uptime，是时间

缺点就是这种方法会有权限问题，ROOT了之后才能使用

dumpsys 拿到的是几个cpu的值，所以可能得到100+%的值

延迟较高，更新较慢。当前的cpuinfo数据已经是90秒之前的信息。





问3：jiffies是什么？

 

全局变量jiffies用来记录自系统启动以来产生的节拍的总数。启动时，内核将该变量初始化为0，此后，每次时钟中断处理程序都会增加该变量的值。

一秒内时钟中断的次数等于Hz，所以jiffies一秒内增加的值也就是Hz。系统运行时间以秒为单位，等于jiffies/Hz

 

more：

http://blog.csdn.net/qinzhonghello/article/details/3588224

https://blog.csdn.net/nonmarking/article/details/77924477

https://www.jianshu.com/p/6bf564f7cdf0

 
4、查看单独app的内存占用：

adb shell dumpsys meminfo 包名
查询后的内容如下：
Applications Memory Usage (kB):
Uptime: 65700249 Realtime: 65700237

** MEMINFO in pid 21828 [com.xxxxxx] **
                   Pss  Private  Private  Swapped     Heap     Heap     Heap
                 Total    Dirty    Clean    Dirty     Size    Alloc     Free
                ------   ------   ------   ------   ------   ------   ------
  Native Heap    31922    31896        0        0    41728    38497     3230
  Dalvik Heap    33868    33796        0        0    44076    43206      870
 Dalvik Other     2093     2092        0        0                           
        Stack      636      636        0        0                           
       Ashmem      136        0        0        0                           
      Gfx dev     9602     4084        0        0                           
    Other dev        4        0        4        0                           
     .so mmap     4049      308     3052        0                           
    .apk mmap      435        0      372        0                           
    .ttf mmap      196        0       92        0                           
    .dex mmap    13097        8    13088        0                           
    .oat mmap     1110        0        0        0                           
    .art mmap     1578     1420        0        0                           
   Other mmap       94        8        0        0                           
      Unknown      352      352        0        0                           
        TOTAL    99172    74600    16608        0    85804    81703     4100
 
 App Summary
                       Pss(KB)
                        ------
           Java Heap:    35216
         Native Heap:    31896
                Code:    16920
               Stack:      636
            Graphics:     4084
       Private Other:     2456
              System:     7964
 
               TOTAL:    99172      TOTAL SWAP (KB):        0
 
 Objects
               Views:       34         ViewRootImpl:        2
         AppContexts:        5           Activities:        1
              Assets:        5        AssetManagers:        2
       Local Binders:       28        Proxy Binders:       26
       Parcel memory:       14         Parcel count:       58
    Death Recipients:        1      OpenSSL Sockets:        1
 
 SQL
         MEMORY_USED:      220
  PAGECACHE_OVERFLOW:      108          MALLOC_SIZE:       62
 
 DATABASES
      pgsz     dbsz   Lookaside(b)          cache  Dbname
         4       84            161     526/551/25  /data/user/0/com.xxxxxx/databases/ces.db
         
Pss对应的TOTAL值：内存所实际占用的值。

Dalvik Heap Size:从RuntimetotalMemory()获得，DalvikHeap总共的内存大小。

Dalvik HeapAlloc:RuntimetotalMemory()-freeMemory() ，Dalvik Heap分配的内存大小。

Dalvik Heap Free:从RuntimefreeMemory()获得，DalvikHeap剩余的内存大小。

Dalvik Heap Size 约等于Dalvik  HeapAlloc+ Dalvik  HeapFree。

Cursor：/dev/ashmem/Cursor Cursor消耗的内存(KB)。

Ashmem：/dev/ashmem，匿名共享内存用来提供共享内存通过分配一个多个进程可以共享的带名称的内存块。

Other dev：/dev/，内部driver占用的在 “Otherdev”。                  

.so mmap：C 库代码占用的内存。

.jar mmap：Java 文件代码占用的内存。

.apk mmap：apk代码占用的内存。

.ttf mmap：ttf 文件代码占用的内存。

.dex mmap：Dex 文件代码占用的内存。

Other mmap：其他文件占用的内存。


memByPkg =99172 KB



5、查询手机整体内存使用情况：
adb shell cat /proc/meminfo
查询后，内容如下：
MemTotal:        2930776 kB
MemFree:          150520 kB
Buffers:          103472 kB
Cached:          1030308 kB
SwapCached:            0 kB
Active:          1663480 kB
Inactive:         557668 kB
Active(anon):    1175396 kB
Inactive(anon):     6316 kB
Active(file):     488084 kB
Inactive(file):   551352 kB
Unevictable:       85472 kB
Mlocked:           82676 kB
HighTotal:       2211836 kB
HighFree:          39196 kB
LowTotal:         718940 kB
LowFree:          111324 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:                 0 kB
Writeback:             0 kB
AnonPages:       1172860 kB
Mapped:           410432 kB
Shmem:              8872 kB
Slab:              81988 kB
SReclaimable:      31628 kB
SUnreclaim:        50360 kB
KernelStack:       17688 kB
PageTables:        37136 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:     1465388 kB
Committed_AS:   38885140 kB
VmallocTotal:     122880 kB
VmallocUsed:        9524 kB
VmallocChunk:      56620 kB


MemTotal = 2930776 KB

计算内存占用率：

某个app的内存占用率 = memByPkg/MemTotal *100

 

　内存耗用：VSS/RSS/PSS/USS
　　Terms
　　•	VSS - Virtual Set Size 虚拟耗用内存（包含共享库占用的内存）
　　•	RSS - Resident Set Size 实际使用物理内存（包含共享库占用的内存）
　　•	PSS - Proportional Set Size 实际使用的物理内存（比例分配共享库占用的内存）
　　•	USS - Unique Set Size 进程独自占用的物理内存（不包含共享库占用的内存）
　　一般来说内存占用大小有如下规律：VSS >= RSS >= PSS >= USS

         
6、获取设备可用内存：adb sell cat /proc/meminfo |grep MemAvailable:   单位是KB



三、Android APP流量测试方法
1、首先获取待测试app的pid:
adb shell ps | grep 包名(windows是findstr)
查询后：
u0_a344   21828 345   1066008 139060 sys_epoll_ 00000000 S com.xxxxxx

2、根据pid获取uid:
adb shell cat /proc/<pid>/status | grep Uid
查询后：
Uid:	10344	10344	10344	10344
3、测试前，执行adb shell cat /proc/net/xt_qtaguid/stats|grep uid获取当前该uid总流量消耗
查询后：
62 wlan0 0x0 10344 0 4624181 52100 7429053 52608 4624181 52100 0 0 0 0 7429053 52608 0 0 0 0
63 wlan0 0x0 10344 1 1486147 2497 332425 2520 1476746 2486 9401 11 0 0 324310 2510 8115 10 0 0
110 lo 0x0 10344 0 587767688 468534 587802864 468553 587767688 468534 0 0 0 0 587802864 468553 0 0 0 0
111 lo 0x0 10344 1 79962776 66887 79966040 66890 79962776 66887 0 0 0 0 79966040 66890 0 0 0 0

其中第6列为rx_bytes（接收数据），第8列为tx_bytes（传输数据）包含tcp，udp等所有网络流量传输的统计。
注意：一个uid可能对应多个进程，将第6列和第8列的数据加一起就是当前的流量消耗




四、Android APP耗电量测试方法

1、首先重启adb:

adb kill-server

adb start-server

使用adb devices查看手机是否连接上电脑

2、重置电池数据：

adb shell dumpsys batterystats --enable full-wake-history 
adb shell dumpsys batterystats --reset

3、拔掉数据线

4、开始进行测试

5、测试完成后使用数据线连接电脑

6、收集电量数据：

android 4.4以前：adb shell dumpsys batteryinfo > batterinfo.txt
android 4.4以后：adb shell dumpsys batterystats > batterystats.txt

7、根据测试的包名找到对应的UID：
8、根据uid查询电量消耗：

Estimated power use (mAh):
    Capacity: 3010, Computed drain: 323, actual drain: 0-30.1
    Bluetooth: 299 ( usage=299 cpu=0.0185 )
    Screen: 9.02
    Cell standby: 3.11 ( radio=3.11 )
    Uid u0a318: 2.84 ( cpu=2.68 wifi=0.151 sensor=0.00811 )
    Uid u0a81: 2.37 ( cpu=0.0185 wifi=2.35 )
    Uid 1000: 2.16 ( cpu=2.08 sensor=0.0810 )
    Uid u0a344: 1.41 ( cpu=1.41 wifi=0.0000423 )
    Uid 0: 0.792 ( cpu=0.792 wifi=0.0000394 )
    Uid u0a3: 0.537 ( cpu=0.523 wifi=0.0000824 sensor=0.0143 )
    Uid 1013: 0.452 ( cpu=0.452 )
    Uid 1036: 0.225 ( cpu=0.225 )
    Wifi: 0.182 ( cpu=0.0120 wifi=0.170 )
    Uid u0a100: 0.166 ( cpu=0.166 )


五、Android CPU温度测试方法:

获取CPU温度的方式：通过读取CPU信息来获取
我们需要获取的是手机CPU内核（thermal）的信息，而这个信息是存储在手机的/sys节点目录中的。有开发经验的朋友就知道，读取手机缓存中的文件是需要有权限的。

而这个权限是需要su权限，也就是root权限。那换而言之，一般的手机是读取不到这个节点信息的。这里也是一个坑，需要注意。

读取路径：/sys/class/thermal/thermal_zone*
这里的*对应了手机的内核文件夹编号，例如某些手机的*可能有17个（0~16），但是需要注意的是并不是所有的文件夹都是存储CPU内核的信息

通过for循环，遍历thermal_zone，cat type出来的信息判断是否包含了以上两种CPU的关键字，则可以判断该目录是否保存了CPU内核信息。
只要判断了那些目录是属于内核信息的，获取温度就手到拈来。只需要cat另一个参数temp那么输出的信息就是我们需要的温度:
代码如下：
#!/bin/sh
while true
do
    for i in {1..40}
        do
            tem=`adb shell cat /sys/class/thermal/thermal_zone$i/temp `
            if [[ -n "$tem" ]];then 
                if [[ ${#tem} -ge "2" ]];then
                    echo  `date +%Y%m%d%H%M%S`'\t'${tem:0:2}'\t' >> temper.txt
                else
                    echo $tem >> temper.txt
                fi
            fi
        done

done
