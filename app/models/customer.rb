class Customer < ApplicationRecord
    validates_presence_of :first_name
    validates_presence_of :last_name
    # validates_presence_of :created_at
    # validates_presence_of :updated_at

    has_many :invoices, :dependent => :destroy

    def self.top_five_customers_by_transaction(merchant_id)
      joins(invoices: [:transactions, :items])
      .where('result = ? and merchant_id = ?', "success", merchant_id)
      .select("customers.*, count('transactions.result') AS successful_transactions")
      .group("customers.id")
      .order(successful_transactions: :desc)
      .limit(5)
    end
end
