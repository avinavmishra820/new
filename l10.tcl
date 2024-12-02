# Set simulation parameters
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
set val(nn) 5          ;# Number of nodes
set val(stop) 60.0     ;# Simulation time
set val(rp) AODV       ;# Routing protocol

# Initialize the simulator
set ns_ [new Simulator]

# Open trace and NAM trace files
set tracefd [open 006.tr w]
$ns_ trace-all $tracefd
set namtrace [open 006.nam w]
$ns_ namtrace-all-wireless $namtrace $val(x) $val(y)

# Define propagation model
set prop [new $val(prop)]
set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)

# Create a god object (for network monitoring)
set god_ [create-god $val(nn)]

# Node Configuration with error model
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
-macTrace ON \
-IncomingErrProc "uniformErr" \
-OutgoingErrProc "uniformErr"

# Error model function (Uniform Error Model)
proc uniformErr {} {
    set err [new ErrorModel]
    $err unit pkt
    $err set rate_ 0.01   ;# Error rate 1%
    return $err
}

# Create Nodes
for {set i 0} {$i < $val(nn)} {incr i} {
    set node_($i) [$ns_ node]
    $node_($i) random-motion 0
}

# Initial Positions of Nodes (5 nodes only)
$node_(0) set X_ 150.0
$node_(0) set Y_ 300.0
$node_(1) set X_ 300.0
$node_(1) set Y_ 500.0
$node_(2) set X_ 500.0
$node_(2) set Y_ 500.0
$node_(3) set X_ 300.0
$node_(3) set Y_ 100.0
$node_(4) set X_ 650.0
$node_(4) set Y_ 300.0

# Initial node positions
for {set i 0} {$i < $val(nn)} {incr i} {
    $ns_ initial_node_pos $node_($i) 40
}

# Set node destinations (simple movement)
$ns_ at 1.0 "$node_(0) setdest 10.0 10.0 50.0"
$ns_ at 1.0 "$node_(1) setdest 10.0 100.0 50.0"
$ns_ at 1.0 "$node_(2) setdest 100.0 100.0 50.0"
$ns_ at 1.0 "$node_(3) setdest 100.0 10.0 50.0"
$ns_ at 1.0 "$node_(4) setdest 50.0 50.0 50.0"

# Generating TCP traffic and FTP applications
set tcp0 [new Agent/TCP]
set sink0 [new Agent/TCPSink]
$ns_ attach-agent $node_(0) $tcp0
$ns_ attach-agent $node_(2) $sink0
$ns_ connect $tcp0 $sink0
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ns_ at 1.0 "$ftp0 start"
$ns_ at 50.0 "$ftp0 stop"

set tcp1 [new Agent/TCP]
set sink1 [new Agent/TCPSink]
$ns_ attach-agent $node_(1) $tcp1
$ns_ attach-agent $node_(2) $sink1
$ns_ connect $tcp1 $sink1
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ns_ at 1.0 "$ftp1 start"
$ns_ at 50.0 "$ftp1 stop"

# Add traffic for node 4 (similar to the other nodes)
set tcp4 [new Agent/TCP]
set sink4 [new Agent/TCPSink]
$ns_ attach-agent $node_(4) $tcp4
$ns_ attach-agent $node_(2) $sink4
$ns_ connect $tcp4 $sink4
set ftp4 [new Application/FTP]
$ftp4 attach-agent $tcp4
$ns_ at 1.0 "$ftp4 start"
$ns_ at 50.0 "$ftp4 stop"

# Simulation Termination
for {set i 0} {$i < $val(nn)} {incr i} {
    $ns_ at $val(stop) "$node_($i) reset"
}
$ns_ at $val(stop) "puts \"NS EXITING...\" ; $ns_ halt"

puts "Starting Simulation..."
$ns_ run

