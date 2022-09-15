require_relative 'priceable'

class Item < ApplicationRecord
  include Priceable
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items
end
