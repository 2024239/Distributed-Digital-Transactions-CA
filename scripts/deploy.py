from web3 import Web3

ganache_url = "http://127.0.0.1:7545"

web3 = Web3(Web3.HTTPProvider(ganache_url))

# check connection
if web3.is_connected():
    print("Success! Connected to Ganache Local Blockchain.")
    print("Current Block Number:", web3.eth.block_number)
else:
    print("Failed to connect to Ganache.")
