class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy

  def self.top_five
    find_by_sql("select distinct a.name, ((c.unit_price * c.quantity) / 100) as \"revenue\"

    from merchants a,
    items b,
    invoice_items c,
    invoices d,
    transactions e

    where a.id = b.merchant_id
    and b.id = c.item_id
    and c.invoice_id = d.id
    and d.id = e.invoice_id
    and e.result = 'success'

    group by a.name, revenue

    order by revenue desc

    limit 5")
  end
end
