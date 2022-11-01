class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  # return array of customer objects that had successfull transactions with the merchant
  def customers_distinct
    self.customers.distinct
  end

  def merchant_successful_transaction_ids
    self.transactions.where(result: "success").pluck("transactions.id")
  end
end