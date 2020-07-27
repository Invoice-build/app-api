# == Schema Information
#
# Table name: tokens
#
#  id         :uuid             not null, primary key
#  code       :text
#  address    :text
#  network    :text             default("mainnet")
#  decimals   :integer          default(18)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :token do
    code { "ETH" }
    address { "0x0000000000000000000000000000000000000000" }
    decimals { 18 }
    network { "mainnet" }
  end
end
