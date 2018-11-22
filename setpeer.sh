
#!/bin/bash
export ORDERER_CA=/opt/ws/crypto-config/ordererOrganizations/orderer.net/msp/tlscacerts/tlsca.orderer.net-cert.pem

if [ $# -lt 2 ];then
	echo "Usage : . setpeer.sh Seller|Transporter|Buyer| <peerid>"
fi
export peerId=$2

if [[ $1 = "Seller" ]];then
	echo "Setting to organization Seller peer "$peerId
	export CORE_PEER_ADDRESS=$peerId.seller.net:7051
	export CORE_PEER_LOCALMSPID=SellerMSP
	export CORE_PEER_TLS_CERT_FILE=/opt/ws/crypto-config/peerOrganizations/seller.net/peers/$peerId.seller.net/tls/server.crt
	export CORE_PEER_TLS_KEY_FILE=/opt/ws/crypto-config/peerOrganizations/seller.net/peers/$peerId.seller.net/tls/server.key
	export CORE_PEER_TLS_ROOTCERT_FILE=/opt/ws/crypto-config/peerOrganizations/seller.net/peers/$peerId.seller.net/tls/ca.crt
	export CORE_PEER_MSPCONFIGPATH=/opt/ws/crypto-config/peerOrganizations/seller.net/users/Admin@seller.net/msp
fi

if [[ $1 = "Transporter" ]];then
	echo "Setting to organization Transporter peer "$peerId
	export CORE_PEER_ADDRESS=$peerId.transporter.com:7051
	export CORE_PEER_LOCALMSPID=TransporterMSP
	export CORE_PEER_TLS_CERT_FILE=/opt/ws/crypto-config/peerOrganizations/transporter.com/peers/$peerId.transporter.com/tls/server.crt
	export CORE_PEER_TLS_KEY_FILE=/opt/ws/crypto-config/peerOrganizations/transporter.com/peers/$peerId.transporter.com/tls/server.key
	export CORE_PEER_TLS_ROOTCERT_FILE=/opt/ws/crypto-config/peerOrganizations/transporter.com/peers/$peerId.transporter.com/tls/ca.crt
	export CORE_PEER_MSPCONFIGPATH=/opt/ws/crypto-config/peerOrganizations/transporter.com/users/Admin@transporter.com/msp
fi

if [[ $1 = "Buyer" ]];then
	echo "Setting to organization Buyer peer "$peerId
	export CORE_PEER_ADDRESS=$peerId.buyer.com:7051
	export CORE_PEER_LOCALMSPID=BuyerMSP
	export CORE_PEER_TLS_CERT_FILE=/opt/ws/crypto-config/peerOrganizations/buyer.com/peers/$peerId.buyer.com/tls/server.crt
	export CORE_PEER_TLS_KEY_FILE=/opt/ws/crypto-config/peerOrganizations/buyer.com/peers/$peerId.buyer.com/tls/server.key
	export CORE_PEER_TLS_ROOTCERT_FILE=/opt/ws/crypto-config/peerOrganizations/buyer.com/peers/$peerId.buyer.com/tls/ca.crt
	export CORE_PEER_MSPCONFIGPATH=/opt/ws/crypto-config/peerOrganizations/buyer.com/users/Admin@buyer.com/msp
fi

	