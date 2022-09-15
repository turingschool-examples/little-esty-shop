class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  validates :first_name, presence: true
  validates :last_name, presence: true


  def self.top_five_customers_by_merchant
    joins(:transactions).where('transactions.result = 0').group(:last_name, :first_name).order(count: :desc).limit(5).count
  end

  def self.top_five_customers_admin
    joins(:transactions).where('result = 0').group(:first_name).order(count: :desc).limit(5).count
  end
end
