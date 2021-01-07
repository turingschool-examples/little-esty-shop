class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :customers, through: :invoices

  def top_five_customers
    require "pry"; binding.pry
    Marchant.joins(:invoices).group("invoice.customer_id").count(:length).max
  end
end
