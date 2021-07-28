class InvoiceItem < ApplicationRecord
  # validates :
  belongs_to :item
  belongs_to :invoice
  # has_many :
  # has_many :, through: :

  enum status: [:pending, :packaged, :shipped]
end