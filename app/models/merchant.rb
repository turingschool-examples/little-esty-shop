class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items

  validates :name, presence: true

  def top_customers
        test = invoices.joins(:customer, :transactions)
                      .where(transactions: {result: true})
                      .select("customers.*, transactions.count as total_count")
                      .group("customers.id")
                      .order(total_count: :desc)
                      .limit(5)
        binding.pry


    # test = items.joins(invoices: :transactions, invoices: :customer)
    #             .where(transactions: {result: true})
    #             .select("customers.*, transactions.count as total_count")
    #             .group("customers.id")
    #             .order(total_count: :desc)
    #             .limit(5)
    #
    # binding.pry
  end
end
