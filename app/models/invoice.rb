class Invoice < ApplicationRecord
  validates_presence_of :status

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [ 'in progress', 'cancelled', 'completed' ]

  scope :incomplete_invoices, -> { includes(:invoice_items).where.not(status: "completed").distinct.order(:created_at)}

  def formatted_date
    created_at.strftime("%A, %B %d, %Y")
  end

  def full_name
    customer.first_name + " " + customer.last_name
  end 
end
