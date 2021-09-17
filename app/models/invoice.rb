class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items

  validates :status, presence: true


  enum status: {
    "in progress": 0,
    "cancelled": 1,
    "completed": 2
  }

  def date
    created_at.strftime("%A, %B %e, %Y")
  end
end
