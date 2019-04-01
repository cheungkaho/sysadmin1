#1. 
rm /dev/sd*

#2.
echo 1 > /sys/block/sdas/device/delete
echo 1 > /sys/block/sdar/device/delete

#3.
multipath -F
