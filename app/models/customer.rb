class Customer < ApplicationRecord

  has_many :invoices, dependent: :destroy
	has_many :transactions, through: :invoices

end
