class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  # def self.merchants_items_all
  #   binding.pry
  # end

end
