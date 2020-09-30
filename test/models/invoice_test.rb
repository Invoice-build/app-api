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
  describe 'eth invoice' do
    def setup
      @line_items = [
        build(:line_item, quantity: 1, unit_price_units: 100e6),
        build(:line_item, quantity: 1, unit_price_units: 200e6),
        build(:line_item, quantity: 1, unit_price_units: 300e6)
      ]
      @invoice = create(:invoice, tax_bps: 1000, line_items: @line_items)
    end

    it 'has correct #subtotal' do
      puts @invoice.tax
      assert_equal @invoice.subtotal, 600
    end

    it 'has correct #tax' do
      assert_equal @invoice.tax, 60
    end

    it 'has correct #total' do
      assert_equal @invoice.total, 660
    end

    it 'has correct #paid_amount' do
      create(:eth_transaction, :confirmed, transactable: @invoice)
      assert_equal @invoice.paid_amount, 0.001
    end
  end

  describe 'erc20 invoice' do
    def setup
      @line_items = [
        build(:line_item, quantity: 1, unit_price_units: 100e6),
        build(:line_item, quantity: 1, unit_price_units: 200e6),
        build(:line_item, quantity: 1, unit_price_units: 300e6)
      ]
      @invoice = create(:invoice, :erc20, tax_bps: 1000, line_items: @line_items)
    end

    it 'has correct #subtotal' do
      puts @invoice.tax
      assert_equal @invoice.subtotal, 600
    end

    it 'has correct #tax' do
      assert_equal @invoice.tax, 60
    end

    it 'has correct #total' do
      assert_equal @invoice.total, 660
    end

    it 'has correct #paid_amount' do
      create(:eth_transaction, :confirmed, transactable: @invoice)
      assert_equal @invoice.paid_amount, 0.001
    end
  end
end
