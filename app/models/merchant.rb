class Merchant < ApplicationRecord
  validates :name, presence: true
  validates :status, presence: true

  has_many :items, dependent: :destroy

  enum status: [ :enabled, :disabled ]

####### dashboard methods #########

  def top_five_customers
    test = Merchant.joins(items: {invoice_items: {invoice: {transactions: {invoice: :customer}}}})
        .where("merchants.id = ?", self.id).where("result = ?", 1).limit(5)
        .group('customers.id', 'customers.first_name', 'customers.last_name').order(count: :desc).count
  end



####### item methods ##############









###### invoice methods ###########

########### admin ############
  def self.top_five_by_revenue
  end
end
