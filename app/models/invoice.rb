class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants #test

  enum status: { cancelled: 0, in_progress: 1, completed: 2}, _prefix: :status

  def total_revenue
    invoice_items.sum("quantity * unit_price")
  end

  def number_status
    status_before_type_cast
  end

  def self.unshipped
    joins(:invoice_items).group(:id).where.not(invoice_items: {status: 2}).order(created_at: :desc)
  end

  def convert_create_date
    self.created_at.strftime("%A, %B %d, %Y")
  end

  def status_for_view
    rev_statuses = {0 => 'cancelled', 1 => 'in_progress', 2 => 'completed'}
    rev_statuses[self.status]
  end

  def merchant_total_revenue(merchant_id)
    # Invoice.joins(:items, :invoice_items, :bulk_discounts).where('items.merchant_id = ?', merchant_id).where('bulk_discounts.merchant_id = ?', merchant_id).where('invoices.id = ?', self.id).where("invoice_items.quantity < bulk_discounts.quantity_threshold ").distinct.sum('invoice_items.unit_price * invoice_items.quantity')
    invoice_items = self.invoice_items.joins(:item, :bulk_discounts).where('items.merchant_id = ?', merchant_id).where('bulk_discounts.merchant_id = ?', merchant_id).distinct

    invoice_items.sum do |invoice_item|
      if invoice_item.discount? == false
        invoice_item.total_rev
      else
        0
      end
    end
  end

  def merchant_discounted_revenue(merchant_id)
    invoice_items = self.invoice_items.joins(:item, :bulk_discounts).where('items.merchant_id = ?', merchant_id).where('bulk_discounts.merchant_id = ?', merchant_id).distinct
    invoice_items.sum do |invoice_item|
      if invoice_item.discount?
        invoice_item.total_rev
      else
        0
      end
    end
  end
end
