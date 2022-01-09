class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  validates :quantity, presence: true, numericality: {only_integer: true}
  validates :unit_price, presence: true, numericality: {only_integer: true}


  enum status: { "pending" => 0, :packaged => 1, "shipped" =>2 }

  def revenue
    quantity * unit_price
  end

  def self.revenue
    InvoiceItem.sum("quantity * unit_price")
  end
end
