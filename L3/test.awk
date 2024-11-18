BEGIN {
    tcp_drop = 0;
    udp_drop = 0;
    total_tcp = 0;
    total_udp = 0;
}

{
    if ($1 == "d" && $5 == "tcp") {
        tcp_drop++;
    }
    if ($1 == "d" && $5 == "cbr") {
        udp_drop++;
    }
    if ($5 == "tcp") {
        total_tcp++;
    }
    if ($5 == "cbr") {
        total_udp++;
    }
}

END {
    print "TCP Sent Packets: " total_tcp;
    print "UDP Sent Packets: " total_udp;
    print "Dropped TCP Packets: " tcp_drop;
    print "Dropped UDP Packets: " udp_drop;
}

