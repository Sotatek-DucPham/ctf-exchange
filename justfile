deploy-collateral network="testnet":
  #!/usr/bin/env bash
  source .env.{{network}}

  forge create \
  --rpc-url $RPC_URL \
  --private-key $PK \
  src/dev/mocks/USDC.sol:USDC
  # 0x81C4bf2A60562D6658006268f5b2e310Da62b0C6

verify-collateral network="testnet":
  #!/usr/bin/env bash
  source .env.{{network}}

  forge verify-contract \
    --chain-id 11155111 \
    --num-of-optimizations 1000000 \
    --watch \
    --etherscan-api-key $ETHERSCAN_API_KEY \
    --compiler-version v0.8.15+commit.e14f2714 \
    $COLLATERAL \
    src/dev/mocks/USDC.sol:USDC

deploy-exchange network="testnet":
  #!/usr/bin/env bash
  source .env.{{network}}

  echo "Deploying CTF Exchange..."
  echo "Deploy args:
  Admin: $ADMIN
  Collateral: $COLLATERAL
  ConditionalTokensFramework: $CTF
  ProxyFactory: $PROXY_FACTORY
  SafeFactory: $SAFE_FACTORY
  "

  OUTPUT="$(forge script ExchangeDeployment \
      --private-key $PK \
      --rpc-url $RPC_URL \
      --json \
      --broadcast \
      -s "deployExchange(address,address,address,address,address)" $ADMIN $COLLATERAL $CTF $PROXY_FACTORY $SAFE_FACTORY)"

  EXCHANGE=$(echo "$OUTPUT" | grep "{" | jq -r .returns.exchange.value)
  echo "Exchange deployed: $EXCHANGE"

  echo "Complete!"
  # 0xB4f8bB7677444cd0C8AF6eAB099eA89b563607ae
