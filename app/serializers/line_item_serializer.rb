# == Schema Information
#
# Table name: line_items
#
#  id            :uuid             not null, primary key
#  invoice_id    :uuid
#  description   :text
#  quantity      :float
#  quantity_type :text
#  unit_price    :float
#  amount        :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class LineItemSerializer < ActiveModel::Serializer
  attributes :id, :description, :quantity, :quantity_type, :unit_price
end
