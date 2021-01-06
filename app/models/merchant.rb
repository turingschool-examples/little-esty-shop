class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def ready_to_ship
    first =  invoice_items
                     .joins(:item)
                     .select('items.id, items.name as item_name, invoices.id as invoice_id, invoices.created_at AS invoice_date')
                     .where.not('invoice_items.status = ?', 2)
                     .order('invoice_date')
  end

  def potential_user_story_3
    @merchant.transactions.select('invoices.customer_id, count(transactions.result) as transaction_count').where('transactions.result = 1').group('invoices.customer_id').order('transaction_count DESC').limit(5)
    def top_5
      @merchant.invoices.joins({customers: :transactions}).select('customers.*, count(transactions.result) as transaction_count').where('transactions.result = ? && invoices.merchant_id = ?', 1, @merchant.id).group(:id).order('transaction_count DESC').limit(5)
    end
  end
end
