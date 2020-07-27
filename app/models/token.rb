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
class Token < ApplicationRecord
  # VALIDATIONS
  validates :code, :address, presence: true
  validates :address, uniqueness: true 

  # SCOPES
  scope :mainnet, -> { where(network: 'mainnet') }
  scope :ropsten, -> { where(network: 'ropsten') }
  scope :by_network, -> (network) { where(network: network) }
end
