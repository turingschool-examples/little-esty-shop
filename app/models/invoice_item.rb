class InvoiceItem < ApplicationRecord
  validates :item_id, presence: true
  validates :invoice_id, presence: true
  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
  validates :status, presence: true, numericality: true

  belongs_to :item
  belongs_to :invoice

  has_one :merchant, through: :item
  has_many :bulk_discounts, through: :merchant

  enum status: {"pending" => 0, "packaged" => 1, "shipped" => 2}

  def has_discount?
    !bulk_discount.nil?
  end

  def bulk_discount
    bulk_discounts.select { |discount| quantity >= discount.quantity }
      .max_by(&:percentage)
  end
end
