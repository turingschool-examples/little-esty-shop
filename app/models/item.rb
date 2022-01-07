class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
<<<<<<< HEAD
<<<<<<< HEAD

=======
  enum status: %i[enabled disabled]
>>>>>>> 1ea1a68b59e14fd52e0ae096c9dbdef87925524a
=======

  enum status: %i[enabled disabled]

>>>>>>> cca6c656a10de4a69717266f2a0fb933827159aa
end
