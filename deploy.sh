#!/usr/bin/env bash
# ============================================================
#  Deploy ArcToken to Arc Testnet
#  Usage: bash deploy.sh
# ============================================================

set -e

export PATH="$HOME/.foundry/bin:$PATH"
export FOUNDRY_DISABLE_NIGHTLY_WARNING=1

# Check that .env exists and private key is set
if [ ! -f .env ]; then
  echo "ERROR: .env file not found."
  echo "Please create the .env file and paste your private key."
  exit 1
fi

source .env

if [ -z "$PRIVATE_KEY" ] || [ "$PRIVATE_KEY" = "YOUR_PRIVATE_KEY_HERE" ]; then
  echo "============================================================"
  echo "  ERROR: Private key not set!"
  echo ""
  echo "  Open the file:  erc20-arc/.env"
  echo "  Find the line:  PRIVATE_KEY=YOUR_PRIVATE_KEY_HERE"
  echo "  Replace it with your actual private key (no 0x prefix)."
  echo "============================================================"
  exit 1
fi

echo "Building contracts..."
forge build

echo ""
echo "Deploying to Arc Testnet..."
forge script script/Deploy.s.sol \
  --rpc-url arc_testnet \
  --broadcast \
  -vvvv

echo ""
echo "Deployment complete! Check the output above for your contract address."
