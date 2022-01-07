class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
<<<<<<< HEAD

=======
  enum status: %i[enabled disabled]
>>>>>>> 1ea1a68b59e14fd52e0ae096c9dbdef87925524a
end
