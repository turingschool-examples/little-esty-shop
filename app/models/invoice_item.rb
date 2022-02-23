class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  enum status: {"pending" => 0, "packaged" => 1, "shipped" => 2}

  def self.order_by_oldest
    order(:created_at)
  end
end
