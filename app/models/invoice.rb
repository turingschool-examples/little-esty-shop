class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: { cancelled: 0, in_progress: 1, completed: 2}, _prefix: :status

  def convert_create_date
    self.created_at.strftime("%A, %B %d, %Y")
  end

  def status_for_view
    rev_statuses = {0 => 'cancelled', 1 => 'in_progress', 2 => 'completed'}
    rev_statuses[self.status]
  end
end
