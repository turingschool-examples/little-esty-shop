class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices
  has_many :items, through: :invoices

  def transaction_count(merchant)
    items.where(merchant_id: merchant.id).count
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
