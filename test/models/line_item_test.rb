# == Schema Information
#
# Table name: line_items
#
#  id               :uuid             not null, primary key
#  invoice_id       :uuid
#  description      :text
#  quantity         :float
#  quantity_type    :text
#  unit_price_units :bigint           not null
#  amount_units     :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
