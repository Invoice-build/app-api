# frozen_string_literal: true

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
#  network           :text             default("mainnet")
#  password_digest   :text
#
require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
