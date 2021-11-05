class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: { "cancelled" => 0,
                 "completed" => 1,
                 "in progress" => 2
               }
<<<<<<< HEAD

  def customer
    Customer.find(self.customer_id)
  end
=======
  def self.successful_invoices
    joins(:transactions).where(transactions: {result: "success"}).distinct
  end

  def invoice_revenue
    invoice_items.sum { |invoice_item| invoice_item.invoice_item_revenue}
  end

>>>>>>> 9e867bc2f46de4d8126976a1136af2147ab7655a
end
