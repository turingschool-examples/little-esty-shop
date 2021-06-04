class Merchant < ApplicationRecord
  validates_presence_of :name
  #status?
  has_many :items
  has_many :invoice_items, through: :items

  # def top_5
  #   items.order('unit_price DESC').limit(5)
  # end

  def top_5
    items.joins(:transactions)
      .select('items.id', 'sum(invoice_items.quantity * invoice_items.unit_price) as revenue', 'transactions.result', 'items.name')
      .where("transactions.result = 'success'")
      .group('items.id')
      .group('transactions.result')
      .order('revenue DESC')
      .limit(5)
  end


end
#
# Item.joins(:transactions).select('items.id', 'sum(invoice_items.quantity * invoice_items.unit_price) as revenue', 'transactions.result').where("transactions.result = 'success'").group('ite
# ms.id').group('transactions.result').where(:merchant_id => 2).order('revenue DESC').limit(5)
