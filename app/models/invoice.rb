class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items

  validates :status, presence: true

  def self.incomplete_invoices
    require "pry"; binding.pry
  end

  enum status: {
    "in progress": 0,
    "cancelled": 1,
    "completed": 2
  }

Invoice.joins(:invoice_items).where("NOT invoice_items.status = 3")
end
