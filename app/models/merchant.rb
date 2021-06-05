class Merchant < ApplicationRecord
  validates_presence_of :name
  #status?
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  def self.top_five_by_successful_transaction
    joins(:invoices, :transactions, :invoice_items).group(:id).select('merchants.*,sum(invoice_items.quantity*invoice_items.unit_price) as total_revenue').where('transactions.result
  = ?', 0).order(total_revenue: :desc).limit(5)
  end

  # def top_5
  #   items.order('unit_price DESC').limit(5)
  # end

  def top_5
    items.joins(:transactions)
      .select('items.*', 'sum(invoice_items.quantity * invoice_items.unit_price) as revenue', 'transactions.result')
      .where("transactions.result = 'success'")
      .group('items.id', 'transactions.result')
      .order('revenue DESC')
      .limit(5)
  end


  def top_days
    items.joins(:transactions)
      .select('items.*', 'sum(invoice_items.quantity * invoice_items.unit_price) as revenue', 'transactions.result', 'invoice_items.updated_at')
      .where("transactions.result = 'success'")
      .group('items.id', 'transactions.result', 'invoice_items.updated_at')
      .order('revenue DESC')
      .limit(9)
  end

  def top_days_per_merchanct
    top_5.map do |item|
      top_days.find do |day|
        if day.name == item.name
          day.name
          day.updated_at
        end
      end
    end
  end

  # def date
  #   Date.parse(updated_at).strftime("%m/%d/%Y")
  # end
end
#
# Item.joins(:transactions).select('items.id', 'sum(invoice_items.quantity * invoice_items.unit_price) as revenue', 'transactions.result').where("transactions.result = 'success'").group('items.id').group('transactions.result').where(:merchant_id => 1).order('revenue DESC').limit(5)

# Item.joins(:transactions).select('items.id', 'sum(invoice_items.quantity * invoice_items.unit_price) as revenue', 'transactions.result', 'invoices.created_at').where("transactions.result =
#  'success'").group('items.id').group('transactions.result').group('invoices.created_at').where(:merchant_id => 2).order('revenue DESC').limit(5)

# items.joins(:transactions).select('items.*', 'sum(invoice_items.quantity * invoice_items.unit_price) as revenue', 'transactions.result', 'invoice_items.updated_at').where("transactions.result = 'success'").group('items.id', 'transactions.result', 'invoice_items.updated_at').order('revenue DESC').limit(5)
