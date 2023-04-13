class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items

  validates :status, presence: true
 
  enum status: ["In Progress", "Completed", "Cancelled"]

  def convert_created_at
    created_at.strftime("%A, %B %d, %Y")
  end

end