class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items, dependent: :destroy
  has_many :customers, through: :invoices, dependent: :destroy
  has_many :transactions, through: :invoices, dependent: :destroy

  def self.unshipped_items
  #  require 'pry'; binding.pry
      # invoice_items.where.not(status: :shipped)
  
      Item.joins(:invoice_items).where('invoice_items.status!=2').distinct.pluck(:name)
  end
end