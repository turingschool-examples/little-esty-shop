class Customer < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name

  has_many :invoices
  has_many :items, through: :invoice_items

  def self.top_5_by_transaction_count
    0
  end
end
