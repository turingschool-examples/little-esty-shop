class Invoice < ApplicationRecord
    enum status:[:'in progress', :cancelled, :completed]

  has_many :invoice_items, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  validates_presence_of :status


end
