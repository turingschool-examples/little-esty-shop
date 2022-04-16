class Invoice < ApplicationRecord
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items, dependent: :destroy
  belongs_to :customer
  has_many :transactions, dependent: :destroy

  enum status: [:cancelled, 'in progress', :completed]

  validates_presence_of :status
  validates_presence_of :created_at
  validates_presence_of :updated_at

  def formatted_created_at
    created_at.strftime('%A, %B %e, %Y')
  end

  def customer_name
    first_name = "#{customer.first_name}"
    last_name ="#{customer.last_name}"
    "#{first_name} #{last_name}"
  end

  def self.incomplete_invoices

   joins(:invoice_items).where(status: [1])
  end

  def self.order_invoices
    order(:created_at)
  end

end
