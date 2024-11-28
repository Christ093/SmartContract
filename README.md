# RequireAssertRevert Smart Contract
This project contains a Solidity smart contract that demonstrates the use of error handling mechanisms such as `require()`, `assert()`, and `revert()` in smart contract development. The contract allows users to mint and burn tokens with specific conditions, ensuring robust error handling and security.

## Contract Overview

The `RequireAssertRevert` smart contract includes the following functionalities:

1. **Mint Tokens**: Allows users to mint new tokens to a specified address. The contract ensures that the mint value is greater than zero.
2. **Burn Tokens**: Allows users to burn tokens from a specified address. The contract ensures that the address has enough tokens to burn.

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

## Error Handling

### `require()`
The `require()` function is used to validate conditions before proceeding with any changes. If the condition fails, the transaction is reverted with a provided error message:
- `"Mint value must be greater than zero"` if the mint value is zero or negative.
- `"Insufficient balance to burn"` if the address does not have enough tokens to burn.

### `assert()`
The `assert()` function is used to ensure the integrity of the contract's state:
- Ensures that balances cannot be negative when burning tokens: `assert(balances[_address] >= 0)`.
- Ensures that the total supply remains consistent after minting or burning tokens.

### `revert()`
The `revert()` function is used to explicitly cancel the transaction and provide an error message:
- `"User balance cannot be zero after burn"` if attempting to burn tokens that would leave the address with zero balance.

## How to Deploy and Interact with the Contract

### Prerequisites:
- **Remix IDE**: Use Remix for compiling and deploying the contract. Visit [Remix IDE](https://remix.ethereum.org/) to start.

### Deployment:
1. Copy the contract code into Remix IDE.
2. Compile the contract using the Solidity compiler in Remix.
3. Deploy the contract to the Remix VM.
4. After deployment, interact with the contract functions from the **Deployed Contracts** section.

### Interacting with Functions:
- **Mint Tokens**: Call the `mint()` function, providing an address and the number of tokens to mint.
- **Burn Tokens**: Call the `burn()` function, providing an address and the number of tokens to burn. Ensure the address has enough tokens.

## Testing

To test the contract’s functionality, you can use Remix IDE’s built-in environment to:
- Mint tokens with valid and invalid values to test `require()`.
- Burn tokens with valid and invalid conditions to test `require()` and `assert()`.
- Test the `revert()` conditions by attempting to burn tokens from an address that already has a zero balance, or by attempting to reduce an account’s balance to zero.

### Example Test Cases:
1. Mint a valid amount of tokens and check if the balance of the specified address is updated.
2. Attempt to burn tokens from an address with insufficient balance (should fail with `require()`).
