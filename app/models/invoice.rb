class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  def format_time
    created_at.strftime("%A, %B %d, %Y")
  end

end
