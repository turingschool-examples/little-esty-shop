class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: {"cancelled" => 0, "in progress" => 1, "completed" => 2}

  validates_presence_of :status

  def total_invoice_revenue
    invoice_items.sum("unit_price * quantity").to_f
  end

  def self.not_completed
    where(:invoices => {status: 1}).order(created_at: :asc)
  end

end
