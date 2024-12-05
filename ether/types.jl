module Types

# Represents an Ethereum address
struct Address
    value::String  # Must be a 42-character hexadecimal string starting with "0x"
    function Address(value::String)
        @assert startswith(value, "0x") && length(value) == 42 && all(c -> c in '0':'9' || c in 'a':'f' || c in 'A':'F', value[3:end])
        return new(value)
    end
end

# Represents an Ethereum account
struct Account
    address::Address
    private_key::String  # Private key should be a 64-character hexadecimal string
end

# Represents a transaction to send to the Ethereum blockchain
struct Transaction
    from_address::Address
    to_address::Address
    value_wei::BigInt  # Value in Wei
    gas_limit::Int
    gas_price_wei::BigInt
    data::Vector{UInt8}  # Optional: byte array of transaction data (default is empty)
end

# Represents an Automated Market Maker (AMM) contract
struct AMM
    address::Address
    abi::String  # JSON ABI string defining the AMM's interface
    tokenA::Address  # Address of the first token in the pair
    tokenB::Address  # Address of the second token in the pair
end

# Enum for different Ethereum networks
@enum EthereumNetwork Mainnet=1 Ropsten=3 Rinkeby=4 Goerli=5 Kovan=42

# Represents an Ethereum node connection
struct NodeConnection
    network::EthereumNetwork
    rpc_url::String
end

# Constants for commonly used values
const WEI_PER_ETHER = big(10)^18

# Utility functions to simplify value conversions
function wei_to_ether(wei::BigInt)::Float64
    return Float64(wei) / WEI_PER_ETHER
end

function ether_to_wei(ether::Float64)::BigInt
    return BigInt(round(ether * WEI_PER_ETHER))
end

end # module Types
