BEGIN { count = 0 }

{
    if ($1 == "r" && $4 == 1 && $5 == "tcp") {
        count += $6; 
        printf("%f\t%f\n", $2, count / 1e6);  # Print time and cumulative data in Mbps
    }
}

