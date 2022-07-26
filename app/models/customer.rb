class Customer < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :transactions, through: :invoices

  def full_name
    first_name + " " + last_name
  end
end
