// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/ArcToken.sol";

/// @notice Deployment script for ArcToken on Arc Testnet.
/// Run with:
///   forge script script/Deploy.s.sol --rpc-url arc_testnet --broadcast --verify
contract DeployArcToken is Script {
    function run() external {
        // Load the private key from the .env file
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        // ─── Token Configuration ──────────────────────────────────────────
        string  memory tokenName    = "Arc Test Token";   // Change to your token name
        string  memory tokenSymbol  = "ARC";              // Change to your token symbol
        uint8          tokenDecimals = 18;                // Standard ERC20 decimals
        uint256        initialSupply = 1_000_000;         // 1 million tokens minted to deployer
        // ─────────────────────────────────────────────────────────────────

        vm.startBroadcast(deployerPrivateKey);

        ArcToken token = new ArcToken(
            tokenName,
            tokenSymbol,
            tokenDecimals,
            initialSupply
        );

        vm.stopBroadcast();

        console.log("======================================");
        console.log("ArcToken deployed successfully!");
        console.log("Contract address:", address(token));
        console.log("Token name:      ", token.name());
        console.log("Token symbol:    ", token.symbol());
        console.log("Total supply:    ", token.totalSupply() / 10 ** tokenDecimals, tokenSymbol);
        console.log("======================================");
    }
}
