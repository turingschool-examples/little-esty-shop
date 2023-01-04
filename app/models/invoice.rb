class Invoice < ApplicationRecord
  belongs_to :customer 
  has_many :transactions
  has_many :invoice_items
  
  validates_presence_of :status

  enum status: {cancelled: 0,
                completed: 1,
                in_progress: 2}

  def format_date_long
    self.created_at.to_formatted_s(:admin_invoice_date)
  end

  def self.find_unshipped
    self.joins(:invoice_items)
    .where.not(invoice_items: {status: "shipped"})
  end

  def self.sort_by_created_date
    order(:created_at)
  end

end