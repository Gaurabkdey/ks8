
#!/bin/bash -e




echo "Building channel for scmchannel" 

. setpeer.sh Transporter peer0
export CHANNEL_NAME="scmchannel"
peer channel create -o orderer.orderer.net:7050 -c $CHANNEL_NAME -f ./scmchannel.tx --tls true --cafile $ORDERER_CA -t 10000


. setpeer.sh Transporter peer0
export CHANNEL_NAME="scmchannel"
peer channel join -b $CHANNEL_NAME.block


. setpeer.sh Buyer peer0
export CHANNEL_NAME="scmchannel"
peer channel join -b $CHANNEL_NAME.block


. setpeer.sh Seller peer0
export CHANNEL_NAME="scmchannel"
peer channel join -b $CHANNEL_NAME.block

