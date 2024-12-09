
BEGIN {
recd=0
hdrsz=0
stoptime=0
starttime=0
}

{
time=$2
if($1=="s" &&  $4=="AGT" && $8>=512) {
if(time<starttime) {
starttime=time
}
}

if($1=="r" &&  $4=="AGT" && $8>=512) {
if(time>starttime) {
stoptime=time
}
hdrsz=$8%512
$8-=hdrsz
recd+=$8
}
}
END {
printf("Goodput=%f Kbps\n", (recd)/(stoptime-starttime)*8/1000)
}


