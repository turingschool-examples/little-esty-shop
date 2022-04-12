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
    created_at.strftime('%A, %B%e, %Y')
  end
end
