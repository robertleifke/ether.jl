# ether.jl

Ether.jl is a Julia package designed to bridge it's scientific computing capabilities with Ethereum. It enables seamless interaction with Ethereum nodes, smart contracts, and on-chain data, making it the ideal tool mechanism researchers and automated market maker designers. 

## Usage 

### Connect to an Ethereum Node

```julia
using ERC20

# Connect to an Ethereum node and ERC-20 contract
connection = ERC20.ERC20Connection("http://localhost:8545", "0xYourTokenAddress")
```
### Retrieve Token Balance

```julia
balance = ERC20.get_balance(connection, "0xYourWalletAddress")
println("Token Balance: $balance")
```

### Transfer Tokens

```julia
result = ERC20.transfer_tokens(connection, "0xSenderAddress", "privateKey", "0xReceiverAddress", 100)
println(result)
```



