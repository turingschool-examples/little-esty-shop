class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many :merchants, through: :item
  has_many :discounts, through: :merchants
  has_many :customers, through: :invoice
  has_many :transactions, through: :invoice

  validates :quantity, presence: true
  validates :unit_price, presence: true
  validates :status, presence: true

  enum status: {'pending' => 0, 'shipped' => 1, 'packaged' => 2}

  def applied_discount
    qualifying_discounts = discounts.map { |discount| discount if discount.quantity_threshold <= self.quantity }
    qualifying_discounts.compact.max_by(&:percentage)
  end
end
