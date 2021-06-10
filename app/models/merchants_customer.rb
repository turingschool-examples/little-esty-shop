class MerchantsCustomer < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
#Create tests if this works
  has_many :invoices, through: :customer
  has_many :transactions, through: :invoices

end
