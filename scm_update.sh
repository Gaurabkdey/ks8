#!/bin/bash
if [[ ! -z "$1" ]]; then  
	. setpeer.sh Transporter peer0 
export CHANNEL_NAME="scmchannel"
	peer chaincode install -n scm -v $1 -p github.com/scm
	. setpeer.sh Buyer peer0 
export CHANNEL_NAME="scmchannel"
	peer chaincode install -n scm -v $1 -p github.com/scm
	. setpeer.sh Seller peer0 
export CHANNEL_NAME="scmchannel"
	peer chaincode install -n scm -v $1 -p github.com/scm
	peer chaincode upgrade -o orderer.orderer.net:7050 --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C scmchannel -n scm -v $1 -c '{"Args":["init",""]}' -P " OR( 'TransporterMSP.member','BuyerMSP.member','SellerMSP.member' ) " 
else
	echo ". scm_updchain.sh  <Version Number>" 
fi
