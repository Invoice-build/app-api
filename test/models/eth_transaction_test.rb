# == Schema Information
#
# Table name: eth_transactions
#
#  id                :uuid             not null, primary key
#  tx_hash           :text
#  reference         :text
#  confirmed_at      :datetime
#  failed_at         :datetime
#  transactable_id   :uuid
#  transactable_type :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  network           :text             default("mainnet")
#
require 'test_helper'

class EthTransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
