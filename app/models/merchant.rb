# app/models/merchant

class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def self.top_five
    select('merchants.name, merchants.id as id, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue')
    .joins(:transactions)
    .where("transactions.result = 'success'")
    .group('merchants.id')
    .order('total_revenue desc')
    .limit(5)
  end

  def top_revenue_day
    invoices
    .joins(:transactions)
    .where("transactions.result = 'success'")
    .select("invoices.created_at, sum(invoice_items.unit_price * invoice_items.quantity)")
    .group(:created_at)
    .order("sum(invoice_items.unit_price * invoice_items.quantity) desc, created_at desc")
    .first
    .created_at
    .to_date

    # sql = ("select z.created_at

    #     from

    #     (select distinct max(x.total_day_revenue) over (partition by x.merchant_id) as \"max_day_revenue\", x.merchant_id

    #     from

    #     (select distinct a.id as \"merchant_id\", d.created_at, sum((c.quantity * c.unit_price) / 100) over (partition by d.created_at) as \"total_day_revenue\"

    #     from merchants a,
    #     items b,
    #     invoice_items c,
    #     invoices d,
    #     transactions e

    #     where a.id = b.merchant_id
    #     and b.id = c.item_id
    #     and c.invoice_id = d.id
    #     and d.id = e.invoice_id
    #     and e.result = 'success') x) y,

    #     (select distinct a.id as \"merchant_id\", d.created_at, sum((c.quantity * c.unit_price) / 100) over (partition by d.created_at) as \"total_day_revenue\"

    #     from merchants a,
    #     items b,
    #     invoice_items c,
    #     invoices d,
    #     transactions e

    #     where a.id = b.merchant_id
    #     and b.id = c.item_id
    #     and c.invoice_id = d.id
    #     and d.id = e.invoice_id
    #     and e.result = 'success') z

    #     where y.max_day_revenue = z.total_day_revenue
    #     and y.merchant_id = z.merchant_id
    #     and z.merchant_id = #{self.id}

    #     order by z.created_at limit 1")

    #    x = ActiveRecord::Base.connection.execute(sql)[0].values[0]
  end

  def self.filter_by_enabled
    Merchant.where(enabled: true)
  end

  def self.filter_by_disabled
    Merchant.where(enabled: false)
  end

  def disabled_items
    items.where(enabled: 1)
  end

  def enabled_items
    items.where(enabled: 0)
  end
end
