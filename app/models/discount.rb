class Discount < ApplicationRecord
  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name, 
                        :threshold, 
                        :percentage

  def discounted_invoice_total
    merchant.invoices.calculate_total_revenue
  end
end
