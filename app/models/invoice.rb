class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions

  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items

  def self.incomplete
    where(status: 'in progress').or(where(status: 'cancelled'))
  end
end
