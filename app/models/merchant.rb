class Merchant < ApplicationRecord
  has_many :items
  validates :name, presence: true

  def transactions_top_5
      Customer.joins(invoices: :transactions).where( transactions: {result: 1}).group(:id).order("transactions.count desc").limit(5)
  end

  #though methods are supposed to be public by default, for some reason these are private unless specified public. not sure why that is.
  def enabled_items
    items.where(enabled: true)
  end

  def disabled_items
    items.where(enabled: false)
  end

  def top_5_items
    require 'pry'; binding.pry
  end
end
