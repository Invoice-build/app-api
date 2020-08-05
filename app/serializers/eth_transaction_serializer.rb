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
#
class EthTransactionSerializer < ActiveModel::Serializer
  attributes :id, :tx_hash, :reference, :failed_at, :confirmed_at, :confirmed, :failed

  def confirmed
    object.confirmed_at?
  end

  def failed
    object.failed_at?
  end
end
