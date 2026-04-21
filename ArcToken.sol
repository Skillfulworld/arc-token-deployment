// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title ArcToken
/// @notice A simple Mintable ERC20 token for deployment on Arc Testnet.
/// @dev Only the owner (deployer) can mint new tokens.
contract ArcToken is ERC20, Ownable {
    uint8 private _decimals;

    constructor(
        string memory name,
        string memory symbol,
        uint8 tokenDecimals,
        uint256 initialSupply
    ) ERC20(name, symbol) Ownable(msg.sender) {
        _decimals = tokenDecimals;
        // Mint the initial supply to the deployer
        _mint(msg.sender, initialSupply * (10 ** tokenDecimals));
    }

    /// @notice Returns the number of decimals used by the token.
    function decimals() public view virtual override returns (uint8) {
        return _decimals;
    }

    /// @notice Mint new tokens. Only callable by the owner.
    /// @param to      Recipient address.
    /// @param amount  Amount of tokens to mint (in full token units, not wei).
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount * (10 ** _decimals));
    }

    /// @notice Mint tokens using the raw amount (in smallest unit / wei).
    /// @param to         Recipient address.
    /// @param rawAmount  Raw amount in the smallest unit (like wei).
    function mintRaw(address to, uint256 rawAmount) external onlyOwner {
        _mint(to, rawAmount);
    }
}
