class Invoice < ApplicationRecord
  enum status: ["cancelled", "completed", "in progress"]

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def creation_date_formatted
    date = self.created_at
    date.strftime("%A, %B %d, %Y")
  end
end
