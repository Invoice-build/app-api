# == Schema Information
#
# Table name: invoices
#
#  id                :uuid             not null, primary key
#  number            :text
#  token_id          :text
#  due_at            :datetime
#  description       :text
#  tax_bps           :integer          default(0)
#  payment_address   :text
#  issuer_contact_id :text
#  client_contact_id :text
#  account_id        :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Invoice < ApplicationRecord
  # ASSOCIATIONS
  has_one :token
  has_many :line_items, dependent: :destroy
  belongs_to :issuer_contact, class_name: 'Contact', foreign_key: 'issuer_contact_id'
  belongs_to :client_contact, class_name: 'Contact', foreign_key: 'client_contact_id'
  
  accepts_nested_attributes_for :issuer_contact, :client_contact
  accepts_nested_attributes_for :line_items, allow_destroy: true

  # VALIDATIONS
  validates :number, :payment_address, :line_items, presence: true
end
