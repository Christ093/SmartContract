// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

contract MyToken {

    // Public variables to store token details
    string public tokenName = "MyToken";  // Token Name
    string public tokenAbbrv = "MTK";     // Token Abbreviation
    uint public totalSupply = 0;          // Total Supply

    // Mapping to store balances of each address
    mapping(address => uint) public balances;

    // Event for Minting
    event Mint(address indexed account, uint value);

    // Event for Burning
    event Burn(address indexed account, uint value);

    // Mint function to increase total supply and update balance of the given address
    function mint(address _address, uint _value) public {
        // Require that the value to mint is greater than zero
        require(_value > 0, "Mint value must be greater than zero");
        
        totalSupply += _value;  // Increase total supply
        balances[_address] += _value;  // Increase the balance of the given address
        
        // Emit the Mint event
        emit Mint(_address, _value);
    }

    // Burn function to reduce total supply and the balance of the given address
    function burn(address _address, uint _value) public {
        // Require that the address has enough tokens to burn
        require(balances[_address] >= _value, "Insufficient balance to burn");
        
        // Use assert to check for an internal consistency condition
        assert(balances[_address] >= 0);  // This should always be true, balances cannot be negative

        totalSupply -= _value;  // Decrease total supply
        balances[_address] -= _value;  // Decrease the balance of the given address
        
        // Emit the Burn event
        emit Burn(_address, _value);
    }

    // Example function to check token balance and ensure the total supply is valid
    function checkTotalSupplyConsistency() public view {
        // Use assert to check that totalSupply is always non-negative
        assert(totalSupply >= 0);  // This should always be true, as total supply can't be negative
    }

    // Example function to demonstrate revert with custom error message
    function resetAccountBalance(address _address) public {
        // If the address has no tokens, revert the transaction with a custom message
        if (balances[_address] == 0) {
            revert("Account already has zero balance");
        }

        balances[_address] = 0;  // Reset the balance to zero
    }
}
