# ether.jl

Ether.jl is a Julia package designed to bridge it's scientific computing capabilities with Ethereum. It enables seamless interaction with Ethereum nodes, smart contracts, and on-chain data, making it the ideal tool mechanism researchers and automated market maker designers. 

## Usage 

```julia
using .Types

# Define an AMM contract
amm = AMM(
    address = Address("0xYourAMMContractAddress"),
    abi = """[
        {
            "constant": true,
            "inputs": [],
            "name": "getReserves",
            "outputs": [
                {"name": "reserveA", "type": "uint112"},
                {"name": "reserveB", "type": "uint112"}
            ],
            "type": "function"
        }
    ]""",
    tokenA = Address("0xTokenAAddress"),
    tokenB = Address("0xTokenBAddress")
)

# Interact with the AMM (using your web3 or other interface functions)
println("AMM address: ", amm.address.value)
println("Token A: ", amm.tokenA.value)
println("Token B: ", amm.tokenB.value)
```


