# Define network parameters
set val(chan) Channel/WirelessChannel
set val(prop) Propagation/TwoRayGround
set val(netif) Phy/WirelessPhy
set val(mac) Mac/802_11
set val(ifq) Queue/DropTail/PriQueue
set val(ll) LL
set val(ant) Antenna/OmniAntenna
set val(x) 500
set val(y) 500
set val(ifqlen) 50
set val(nn) 25     ;# Number of nodes
set val(stop) 200.0;# Time to stop simulation (200 seconds)
set val(rp) AODV   ;# Routing Protocol (AODV)
set val(sc) "mob-25-50" ;# Scenario file (mobility)

# Create simulator object
set ns_ [new Simulator]

# Open trace and nam files
set tracefd [open 003.tr w]
$ns_ trace-all $tracefd
set namtrace [open 003.nam w]
$ns_ namtrace-all-wireless $namtrace $val(x) $val(y)

# Set up topology and propagation model
set prop [new $val(prop)]
set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)
set god_ [create-god $val(nn)]

# Node configuration (using AODV routing)
$ns_ node-config -adhocRouting $val(rp) \
    -llType $val(ll) \
    -macType $val(mac) \
    -ifqType $val(ifq) \
    -ifqLen $val(ifqlen) \
    -antType $val(ant) \
    -propType $val(prop) \
    -phyType $val(netif) \
    -channelType $val(chan) \
    -topoInstance $topo \
    -agentTrace ON \
    -routerTrace ON \
    -macTrace ON

# Create mobile nodes and assign positions
for {set i 0} {$i < $val(nn)} {incr i} {
    set node_($i) [$ns_ node]
    $node_($i) random-motion 1    ;# Enable random motion (1 = true)
}

# Initial random positions for nodes
for {set i 0} {$i < $val(nn)} {incr i} {
    set xx [expr rand() * 500]
    set yy [expr rand() * 400]
    $node_($i) set X_ $xx
    $node_($i) set Y_ $yy
}

# Set initial node positions
for {set i 0} {$i < $val(nn)} {incr i} {
    $ns_ initial_node_pos $node_($i) 40
}

# Loading scenario file for mobility
puts "Loading scenario file..."
source $val(sc)

# **Generating TCP traffic between Node 0 and Node 1**
# Create TCP connection (Node 0 -> Node 1)
set tcp [new Agent/TCP]
$ns_ attach-agent $node_(0) $tcp

# Create a sink (Node 1)
set sink [new Agent/TCPSink]
$ns_ attach-agent $node_(1) $sink

# Connect the TCP agent and sink
$ns_ connect $tcp $sink

# Set up traffic (start the connection)
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $tcp

# Set traffic characteristics (Packet size: 500 bytes, Interval: 0.05 seconds)
$cbr set packetSize_ 500
$cbr set interval_ 0.05

# Start traffic at time 1.0 seconds
$ns_ at 1.0 "$cbr start"

# Stop the traffic after 150 seconds
$ns_ at 150.0 "$cbr stop"

# Simulation Termination
for {set i 0} {$i < $val(nn)} {incr i} {
    $ns_ at $val(stop) "$node_($i) reset"
}

$ns_ at $val(stop) "puts \"NS EXITING...\" ; $ns_ halt"

# Run the simulation
puts "Starting Simulation..."
$ns_ run

