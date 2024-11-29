// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.28;

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
    function mint(address _address, uint _value) external {
        // Require that the value to mint is greater than zero
        require(_value > 0, "Mint value must be greater than zero");

        uint previousTotalSupply = totalSupply;  // Store the previous total supply
        
        totalSupply += _value;  // Increase total supply
        balances[_address] += _value;  // Increase the balance of the given address
        
        // Use assert to check that total supply has increased correctly
        assert(totalSupply == previousTotalSupply + _value);  // Ensure the total supply increased by the minted value
        
        // Emit the Mint event
        emit Mint(_address, _value);
    }

    // Burn function to reduce total supply and the balance of the given address
    function burn(address _address, uint _value) external {
        // Use revert() to terminate the transaction if the balance is insufficient
        if (balances[_address] < _value) {
            revert("Insufficient balance to burn");
        }

        uint previousTotalSupply = totalSupply;  // Store the previous total supply
        
        totalSupply -= _value;  // Decrease total supply
        balances[_address] -= _value;  // Decrease the balance of the given address
        
        // Use assert to check that total supply has decreased correctly
        assert(totalSupply == previousTotalSupply - _value);  // Ensure the total supply decreased by the burned value
        
        // Emit the Burn event
        emit Burn(_address, _value);
    }
}
