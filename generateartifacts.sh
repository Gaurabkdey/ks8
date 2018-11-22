
#!/bin/bash -e
export PWD=`pwd`

export FABRIC_CFG_PATH=$PWD
export ARCH=$(uname -s)
export CRYPTOGEN=$PWD/bin/cryptogen
export CONFIGTXGEN=$PWD/bin/configtxgen

function generateArtifacts() {
	
	echo " *********** Generating artifacts ************ "
	echo " *********** Deleting old certificates ******* "
	
        rm -rf ./crypto-config
	
        echo " ************ Generating certificates ********* "
	
        $CRYPTOGEN generate --config=$FABRIC_CFG_PATH/crypto-config.yaml
        
        echo " ************ Generating tx files ************ "
	
		$CONFIGTXGEN -profile OrdererGenesis -outputBlock ./genesis.block
		
        $CONFIGTXGEN -profile scmChannel -outputCreateChannelTx ./scmchannel.tx -channelID scmchannel
		

}
function generateDockerComposeFile(){
	OPTS="-i"
	if [ "$ARCH" = "Darwin" ]; then
		OPTS="-it"
	fi
	cp  docker-compose-template.yaml  docker-compose.yaml
	
	
	cd  crypto-config/peerOrganizations/seller.net/ca
	PRIV_KEY=$(ls *_sk)
	cd ../../../../
	sed $OPTS "s/SELLER_PRIVATE_KEY/${PRIV_KEY}/g"  docker-compose.yaml
	
	
	cd  crypto-config/peerOrganizations/transporter.com/ca
	PRIV_KEY=$(ls *_sk)
	cd ../../../../
	sed $OPTS "s/TRANSPORTER_PRIVATE_KEY/${PRIV_KEY}/g"  docker-compose.yaml
	
	
	cd  crypto-config/peerOrganizations/buyer.com/ca
	PRIV_KEY=$(ls *_sk)
	cd ../../../../
	sed $OPTS "s/BUYER_PRIVATE_KEY/${PRIV_KEY}/g"  docker-compose.yaml
	
}
generateArtifacts 
cd $PWD
generateDockerComposeFile
cd $PWD

