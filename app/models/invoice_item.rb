class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

<<<<<<< HEAD
  enum status: [ "pending", "packaged", "shipped" ]

=======
  enum status: [ :pending, :packaged, :shipped ]

  def item_name
    item.name
  end
>>>>>>> 2c14a14b8b8fef53b8ff6a7ce4cc44d8f4fde640
end
