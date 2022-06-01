class Invoice < ApplicationRecord
  belongs_to :customer

  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  validates :status, presence: true

  enum status: {'cancelled' => 0, 'in progress' => 1, 'completed' => 2}

  def self.invoices_with_merchant_items(merchant)
    merchant.invoices.uniq
  end

  def invoice_customer
    "#{customer.first_name} #{customer.last_name}"
  end
end
