class Invoice < ApplicationRecord
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :customer

  validates :status, presence: true
  enum status: [ :in_progress, :completed, :cancelled ]

  def total_revenue
    require "pry"; binding.pry
    invoice = Invoice.joins(:invoice_items).group(:quantity, :unit_price).select('quantity * unit_price AS totalrevenue')

    leads.each { |lead| puts lead.totalrevenue }
  end
end
