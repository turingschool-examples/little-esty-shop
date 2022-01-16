class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  validates :first_name, presence: true
  validates :last_name, presence: true

  scope :successful_transactions_count, -> {
    joins(:invoices => :transactions)
    .select("customers.*, count(transactions.id) as count_transactions_id")
    .where(:transactions => {result: 0})
    .group(:id)
    .order(count_transactions_id: :desc)}

  def successful_transactions_count
    successful_transactions.count
  end

  def successful_transactions
    transactions.where(result: 0).distinct
  end

  def full_name
    (self.first_name) + " " + (self.last_name)
  end
end
