class Customer < ApplicationRecord
  has_many :invoices

  validates :first_name, presence: true
  validates :last_name, presence: true

  def successful_transactions_count
    total = invoices.joins(:transactions).where(:transactions => {result: 0}).count
  end

  def full_name
    (self.first_name) + " " + (self.last_name)
  end
end
