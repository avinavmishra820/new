BEGIN {
    tcp_drop = 0;
    udp_drop = 0;
}

{
    if ($1 == "d" && $5 == "tcp") {
        tcp_drop++;
    }
    if ($1 == "d" && $5 == "cbr") {
        udp_drop++;
    }
}

END {
    printf("Dropped TCP Packets: %d\n", tcp_drop);
    printf("Dropped UDP Packets: %d\n", udp_drop);
}

