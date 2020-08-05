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
FactoryBot.define do
  factory :eth_transaction do
    tx_hash { "MyText" }
    reference { "MyText" }
    confirmed_at { "2020-07-29 18:34:06" }
    failed_at { "2020-07-29 18:34:06" }
    transactable_id { "" }
    transactable_type { "MyText" }
  end
end
