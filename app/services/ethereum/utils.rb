module Ethereum
  module Utils
    extend self

    def from_wei(value)
      value / 1e18
    end

    def genesis_address
      '0x0000000000000000000000000000000000000000'
    end
  end
end
