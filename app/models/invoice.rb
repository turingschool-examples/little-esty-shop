class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  validates_presence_of :status

  enum status: { "in progress" => 0, "cancelled" => 1, "completed" => 2 }

  def item_quantity(arg)
    items.where(["name = ? and description = ?", arg.name, arg.description]).count
  end
end
