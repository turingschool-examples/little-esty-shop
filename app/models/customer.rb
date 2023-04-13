class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, -> { distinct }, through: :invoice_items
  has_many :merchants, -> { distinct }, through: :items

  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.top_5_by_transactions
    select("customers.*, count(transactions.id) as result_count").joins(:transactions).where("transactions.result = true").group(:id).order(result_count: :desc).limit(5)
  end

  def get_name
    "#{first_name} #{last_name}"
  end

  def count_successful_transactions
    transactions.where(result: true).size
  end
end
