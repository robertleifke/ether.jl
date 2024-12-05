module ERC20

using HTTP, JSON

export ERC20Connection, get_balance, transfer_tokens, get_symbol, get_decimals, get_total_supply

"""
    ERC20Connection(node_url::String, contract_address::String)

Represents a connection to an Ethereum node and a specific ERC-20 contract.
"""
struct ERC20Connection
    node_url::String
    contract_address::String
end

"""
    json_rpc_request(node_url::String, method::String, params::Vector)

Sends a JSON-RPC request to the Ethereum node and returns the result.
"""
function json_rpc_request(node_url::String, method::String, params::Vector)
    request_body = JSON.json(Dict("jsonrpc" => "2.0", "method" => method, "params" => params, "id" => 1))
    headers = ["Content-Type" => "application/json"]
    response = HTTP.request("POST", node_url, headers, request_body)
    result = JSON.parse(String(response.body))
    if haskey(result, "result")
        return result["result"]
    else
        error("JSON-RPC Error: $(result)")
    end
end

"""
    create_data(method_signature::String, args::Vector)

Encodes an ERC-20 function call into the appropriate ABI-encoded data string.
"""
function create_data(method_signature::String, args::Vector)
    # Hash the method signature to get the first 4 bytes
    method_hash = Base.hexdigest(method_signature)[1:8]
    # Encode the arguments as 32-byte padded hex strings
    encoded_args = join(["$(Base.hexpad(string(arg), 64))" for arg in args])
    "0x$(method_hash)$(encoded_args)"
end

"""
    get_balance(connection::ERC20Connection, address::String)

Gets the token balance of an Ethereum address.
"""
function get_balance(connection::ERC20Connection, address::String)
    method_signature = "balanceOf(address)"
    data = create_data(method_signature, [address])
    params = [Dict("to" => connection.contract_address, "data" => data), "latest"]
    raw_balance = json_rpc_request(connection.node_url, "eth_call", params)
    parse(Int, raw_balance, base=16)
end

"""
    transfer_tokens(connection::ERC20Connection, from::String, private_key::String, to::String, amount::Int)

Transfers tokens from one address to another. Requires the sender's private key.
"""
function transfer_tokens(connection::ERC20Connection, from::String, private_key::String, to::String, amount::Int)
    method_signature = "transfer(address,uint256)"
    data = create_data(method_signature, [to, amount])
    # For simplicity, mock sending the transaction
    println("Transaction Data: $(data)")
    println("From: $(from), To: $(to), Amount: $(amount)")
    "Transaction sent (mock implementation)."
end

"""
    get_symbol(connection::ERC20Connection)

Gets the symbol of the ERC-20 token.
"""
function get_symbol(connection::ERC20Connection)
    method_signature = "symbol()"
    data = create_data(method_signature, [])
    params = [Dict("to" => connection.contract_address, "data" => data), "latest"]
    raw_symbol = json_rpc_request(connection.node_url, "eth_call", params)
    String(raw_symbol)
end

"""
    get_decimals(connection::ERC20Connection)

Gets the decimals used by the ERC-20 token.
"""
function get_decimals(connection::ERC20Connection)
    method_signature = "decimals()"
    data = create_data(method_signature, [])
    params = [Dict("to" => connection.contract_address, "data" => data), "latest"]
    parse(Int, json_rpc_request(connection.node_url, "eth_call", params))
end

"""
    get_total_supply(connection::ERC20Connection)

Gets the total supply of the ERC-20 token.
"""
function get_total_supply(connection::ERC20Connection)
    method_signature = "totalSupply()"
    data = create_data(method_signature, [])
    params = [Dict("to" => connection.contract_address, "data" => data), "latest"]
    raw_supply = json_rpc_request(connection.node_url, "eth_call", params)
    parse(Int, raw_supply, base=16)
end

end # module
