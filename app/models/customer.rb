# app/models/customer

class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  def self.top_five
    # What do you want to see here - a joins table or two AR calls to effectuate the one SQL statement below
    # Customer.joins(invoices: [:transactions]).select("customers.*, count(transactions.*) as num_trans").where("transactions.result = 'success'").distinct.group(:id).order("num_trans desc").limit(5).order(:first_name)

    find_by_sql("select distinct concat(a.first_name, ' ', a.last_name) as \"name\", count(c.result) as \"transactions\"

    From
    customers a,
    invoices b,
    transactions c

    Where a.id = b.customer_id
    and b.id = c.invoice_id
    and c.result = 'success'

    group by a.id

    order by transactions desc, name

    limit 5")
  end
end