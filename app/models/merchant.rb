class Merchant < ApplicationRecord
	validates :name, presence: true
	enum status: [ "active", "disabled" ]
  has_many :items
  has_many :invoices, through: :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def top_five_customers
   
  end
end
