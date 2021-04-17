class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates_presence_of :name

  enum status: [:disabled, :enabled]

  def most_popular_items
    joins(:items).
    select("merchants.name, max(unit_price) as max_unit_price").
    group(:id)
    #I need to add a limit of 5 somewhere
  end 


  def self.disabled_merchants
    where(status: "disabled")
  end

  def self.enabled_merchants
    where(status: "enabled")
  end
end
