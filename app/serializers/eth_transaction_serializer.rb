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
class EthTransactionSerializer < BaseSerializer
  attributes :id, :tx_hash, :reference, :network, :failed_at, :confirmed_at, 
             :confirmed, :failed, :status, :details, :token, :finalized, :finalized_at

  def token
    serialize object.token
  end

  def finalized_at
    object.confirmed_at || object.failed_at
  end

  def finalized
    object.confirmed_at? || object.failed_at?
  end

  def confirmed
    object.confirmed_at?
  end

  def failed
    object.failed_at?
  end
end
