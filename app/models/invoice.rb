class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items

  validates :status, presence: true

  enum status: ["In Progress", "Completed", "Cancelled"]

  def self.find_incomplete_invoices
    joins(:invoice_items).where('invoice_items.status != ?', '2').group(:id).order(:id)
  end
end