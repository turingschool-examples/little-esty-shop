class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  validates_presence_of :status
  validates_presence_of :created_at
  validates_presence_of :updated_at


end
