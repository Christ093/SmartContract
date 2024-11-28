# RequireAssertRevert Smart Contract
This project contains a Solidity smart contract that demonstrates the use of error handling mechanisms such as `require()`, `assert()`, and `revert()` in smart contract development. The contract allows users to mint and burn tokens with specific conditions, ensuring robust error handling and security.

## Contract Overview

The `RequireAssertRevert` smart contract includes the following functionalities:

1. **Mint Tokens**: Allows users to mint new tokens to a specified address. The contract ensures that the mint value is greater than zero.
2. **Burn Tokens**: Allows users to burn tokens from a specified address. The contract ensures that the address has enough tokens to burn.
3. **Check Total Supply**: Allows anyone to check the consistency of the total supply, ensuring it's non-negative.
4. **Reset Account Balance**: Allows the owner to reset an account’s balance to zero, but prevents resetting if the balance is already zero.

### Key Features:
- **require()**: Validates conditions like minting tokens with a non-zero value, burning tokens with sufficient balance, and other input conditions.
- **assert()**: Ensures that the contract's internal state, such as balances and total supply, is always consistent and non-negative.
- **revert()**: Reverts transactions with an appropriate error message if certain conditions are met, such as preventing the balance from becoming zero after a burn operation.

## Functions

### 1. `mint(address _address, uint _value)`
- **Parameters**: 
  - `address _address` - The address that will receive the minted tokens.
  - `uint _value` - The number of tokens to mint.
- **Usage**: Deposits the specified amount of tokens to the given address.
- **Conditions**:
  - Ensures that the `_value` is greater than zero using `require()`.
  - The `totalSupply` and the specified address's balance are updated accordingly.

### 2. `burn(address _address, uint _value)`
- **Parameters**: 
  - `address _address` - The address from which tokens will be burned.
  - `uint _value` - The number of tokens to burn.
- **Usage**: Allows a user to burn a specified amount of tokens from their balance.
- **Conditions**:
  - Only allows burning if the address has enough tokens using `require()`.
  - Ensures no negative balances using `assert()`.
  - Emits a `revert()` if the burn leaves the address with zero tokens.

### 3. `checkTotalSupplyConsistency()`
- **Usage**: Verifies that the `totalSupply` is non-negative using `assert()`.
  
### 4. `resetAccountBalance(address _address)`
- **Parameters**: 
  - `address _address` - The address whose balance will be reset to zero.
- **Usage**: Resets the balance of the specified address to zero.
- **Conditions**:
  - Reverts if the balance of the given address is already zero using `revert()`.

## Error Handling

### `require()`
The `require()` function is used to validate conditions before proceeding with any changes. If the condition fails, the transaction is reverted with a provided error message:
- `"Mint value must be greater than zero"` if the mint value is zero or negative.
- `"Insufficient balance to burn"` if the address does not have enough tokens to burn.

### `assert()`
The `assert()` function is used to ensure the integrity of the contract's state:
- Ensures that balances cannot be negative when burning tokens: `assert(balances[_address] >= 0)`.
- Ensures that the total supply cannot be negative: `assert(totalSupply >= 0)`.

### `revert()`
The `revert()` function is used to explicitly cancel the transaction and provide an error message:
- `"User balance cannot be zero after burn"` if attempting to burn tokens that would leave the address with zero balance.
- `"Account already has zero balance"` if trying to reset an account’s balance when it's already zero.

## How to Deploy and Interact with the Contract

### Prerequisites:
- **Remix IDE**: Use Remix for compiling and deploying the contract. Visit [Remix IDE](https://remix.ethereum.org/) to start.

### Deployment:
1. Copy the contract code into Remix IDE.
2. Compile the contract using the Solidity compiler in Remix.
3. Deploy the contract to the Remix VM (or a testnet like Rinkeby for real-world interactions).
4. After deployment, interact with the contract functions from the **Deployed Contracts** section.

### Interacting with Functions:
- **Mint Tokens**: Call the `mint()` function, providing an address and the number of tokens to mint.
- **Burn Tokens**: Call the `burn()` function, providing an address and the number of tokens to burn. Ensure the address has enough tokens.
- **Check Total Supply**: Call the `checkTotalSupplyConsistency()` function to verify that the total supply is non-negative.
- **Reset Account Balance**: Call the `resetAccountBalance()` function to reset the balance of a specific address to zero. Ensure the balance is non-zero before calling this function.

## Testing

To test the contract’s functionality, you can use Remix IDE’s built-in environment to:
- Mint tokens with valid and invalid values to test `require()`.
- Burn tokens with valid and invalid conditions to test `require()` and `assert()`.
- Test the `revert()` conditions by attempting to burn tokens leaving the address with zero balance or resetting an account’s balance when it's already zero.

### Example Test Cases:
1. Mint a valid amount of tokens and check if the balance of the specified address is updated.
2. Attempt to burn tokens from an address with insufficient balance (should fail with `require()`).
3. Attempt to burn tokens leaving the address with zero balance (should fail with `revert()`).
4. Attempt to reset the balance of an address with zero tokens (should fail with `revert()`).
