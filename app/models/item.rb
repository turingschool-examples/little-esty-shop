class Item < ApplicationRecord
    validates_presence_of :name
    validates_presence_of :description
    validates_presence_of :status
    validates :unit_price, presence: true, numericality: true

    belongs_to :merchant
    has_many :invoice_items, dependent: :destroy
    has_many :invoices, through: :invoice_items
    has_many :transactions, through: :invoices

    enum status: [ :disabled, :enabled ]

    def best_day(id)
      Item.joins(:transactions)
      .where(transactions: {result: 'success'})
      .find(id)
      .invoice_items
      .order('quantity desc')
      .first
      .created_at
      .to_date
      .strftime("%m/%d/%Y")
    end
end
