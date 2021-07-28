class Customer < ApplicationRecord
  has_many :invoices
  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.top_customers_for_merchant(merchant_id)
    # stuff
  end
end
