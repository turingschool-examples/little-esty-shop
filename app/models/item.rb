class Item < ApplicationRecord
  belongs_to(:merchant)
  has_many(:invoice_items)
  has_many(:invoices, through: :invoice_items)

  enum status: {"disabled" => 0, "enabled" => 1}

  def self.only_enabled
    where(status: 1)
  end

  def self.only_disabled
    where(status: 0)
  end

  def revenue_generated
    invoice_items.sum('quantity*unit_price')
  end

  def self.top_5
    find_by_sql("
      SELECT items.id, items.name, sum(invoice_items.quantity*invoice_items.unit_price) AS revenue
      FROM items JOIN invoice_items ON invoice_items.item_id = items.id
      GROUP BY items.id
      ORDER BY revenue DESC
      LIMIT 5
    ")
  end

  def best_selling_date
    invoice_items.order(Arel.sql('quantity*unit_price')).first.created_at
    #Great caution should be taken to avoid SQL injection vulnerabilities.
    #This method should not be used with unsafe values such as request parameters or model attributes.
  end

end
