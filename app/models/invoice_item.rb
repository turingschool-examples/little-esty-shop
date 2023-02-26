class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_many :customer, through: :invoice

  enum status: ["pending", "packaged", "shipped"]
end
