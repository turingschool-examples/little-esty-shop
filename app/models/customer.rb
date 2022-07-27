class Customer < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :created_at
  validates_presence_of :updated_at

  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :transactions, through: :invoices 

  def name 
    first_name + " " + last_name
  end
end
