class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items

  def self.in_progress
    where(status: 'in progress')
  end

  def self.order_from_oldest
    order(created_at: :desc)
  end
end
