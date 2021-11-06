class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  def number_of_transactions
    if self.invoices.count != 0
      join_table = Customer.select("customers.id as id, customers.first_name as first_name, customers.last_name as last_name, count(transactions) as transaction_count").where("transactions.result = '0'").group("transactions.result").joins(:invoices).group("customers.id").joins(:transactions).group('invoices').find_by(id: self.id)
      if join_table != nil
        return join_table.transaction_count
      else
        return 0
      end
    else
      return 0
    end
  end
  def self.top_5
    top_5 = Customer.select("customers.id as id, customers.first_name as first_name, customers.last_name as last_name, count(transactions) as transaction_count").where("transactions.result = '0'").group("transactions.result").joins(:invoices).group("customers.id").joins(:transactions).group('invoices').order('transaction_count DESC').distinct.limit(5)
  end
end
