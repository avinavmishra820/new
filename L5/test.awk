BEGIN {
    sent1 = 0; recv1 = 0; sent2 = 0; recv2 = 0
}

{
    # Check for sent packets (group 1 or group 2)
    if ($1 == "+" && $5 == "cbr") {
        if ($3 == 4) sent1 += $6  # Sent from node 4 (Group 1)
        if ($3 == 5) sent2 += $6  # Sent from node 5 (Group 2)
    }

    # Check for received packets (group 1 or group 2)
    if ($1 == "r" && $5 == "cbr") {
        if ($3 == 4) recv1 += $6  # Received at node 4 (Group 1)
        if ($3 == 5) recv2 += $6  # Received at node 5 (Group 2)
    }
}

END {
    # Print results in Mbps
    print "Group 1 Sent: ", sent1 / 1e6, "Mbps  Recvd: ", recv1 / 1e6, "Mbps"
    print "Group 2 Sent: ", sent2 / 1e6, "Mbps  Recvd: ", recv2 / 1e6, "Mbps"
}

