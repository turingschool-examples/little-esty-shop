class Merchant < ApplicationRecord
  enum status: {enabled: 0, disabled: 1}
  validates :name, presence: true
  validates :status, presence: true


  has_many :items

  def merchant_items
    items.all
  end

  def self.merchant_invoices(merchant_id)
    result = Invoice.find_by_sql("SELECT invoices.*, COUNT(merchants.*) AS
       merchant_count,
       COUNT(items.*) AS item_count
       FROM invoices
       INNER JOIN invoice_items ON invoices.id = invoice_items.invoice_id
       INNER JOIN items ON invoice_items.item_id = items.id
       INNER JOIN merchants ON items.merchant_id = merchants.id
       WHERE merchants.id = #{merchant_id}
          GROUP BY invoices.id
      ORDER BY item_count DESC LIMIT 10")
  end
end
