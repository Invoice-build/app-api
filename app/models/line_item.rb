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
class LineItem < ApplicationRecord
  # ASSOCIATIONS
  belongs_to :invoice

  # CALLBACKS
  before_save :set_amount

  # VALIDATIONS
  validates :description, :quantity, :quantity_type, :unit_price, presence: true

  private

  def set_amount
    self.amount = self.unit_price * self.quantity
  end
end
