set ns [new Simulator]
set tf [open 4.tr w]
$ns trace-all $tf
set nf [open 4.nam w]
$ns namtrace-all $nf

set s [$ns node]  ;# Server
set c [$ns node]  ;# Client

$ns color 1 Blue
$s label "Server"
$c label "Client"

$ns duplex-link $s $c 10Mb 22ms DropTail
$ns duplex-link-op $s $c orient right

set tcp_agent [new Agent/TCP]
$ns attach-agent $s $tcp_agent
$tcp_agent set packetSize_ 1500

set sink_agent [new Agent/TCPSink]
$ns attach-agent $c $sink_agent
$ns connect $tcp_agent $sink_agent

set ftp_app [new Application/FTP]
$ftp_app attach-agent $tcp_agent
$tcp_agent set fid_ 1

proc finish {} {
    global ns tf nf
    $ns flush-trace
    close $tf
    close $nf
    exec nam 4.nam &
    exec awk -f cal.awk 4.tr &
    exec awk -f con.awk 4.tr > convert.tr &
    exec xgraph convert.tr -geometry 800x400 -t "Bytes_received_at_Client" -x "Time_in_secs" -y "Bytes_in_bps" &
}

$ns at 0.01 "$ftp_app start"
$ns at 15.0 "$ftp_app stop"
$ns at 15.1 "finish"
$ns run

