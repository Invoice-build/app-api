namespace :seed do
  task tokens: :environment do
    Token.create(code: 'ETH', address: '0x0000000000000000000000000000000000000000')
    Token.create(code: 'DAI', address: '0x6b175474e89094c44da98b954eedeac495271d0f')
    Token.create(code: 'USDC', address: '0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48', decimals: 6)
    Token.create(code: 'USDT', address: '0xdac17f958d2ee523a2206206994597c13d831ec7', decimals: 6)
  end
end
