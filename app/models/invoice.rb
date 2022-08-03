class Invoice < ApplicationRecord
    enum status: {in_progress: 0, cancelled: 1, completed: 2}

        validates_presence_of :status

        belongs_to :customer
        has_many :invoice_items
        has_many :items, through: :invoice_items
        has_many :transactions

  def invoice_customers
    customer
  end

end
