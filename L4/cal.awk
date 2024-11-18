
BEGIN {
    rcvd = 0;
    sent = 0;
}
{
    if ($1 == "r" && $4 == 1 && $5 == "tcp" && $6 > 0) {
        rcvd += $6; 
    }
    if ($1 == "+" && $3 == 0 && $5 == "tcp" && $6 > 0) {
        sent += $6;  
    }
}
END {
    if ($2 > 0) {
        printf("Time to transfer: %f\n", $2); 
    } else {
        printf("Invalid time data.\n");
    }
    printf("Sent: %f Mbps\n", sent / 1e6);
    printf("Received: %f Mbps\n", rcvd / 1e6);
}

