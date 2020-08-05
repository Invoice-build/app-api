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
class EthTransaction < ApplicationRecord
    # CALLBACKS
    after_create :poll_for_confirmation

    # ASSOCIATIONS
    belongs_to :transactable, polymorphic: true
  
    # VALIDATIONS
    validates :tx_hash, :reference, :transactable_id, :transactable_type, presence: true
  
    private
  
    def poll_for_confirmation
      PollForConfirmationJob.perform_later(self.id)
    end
end
