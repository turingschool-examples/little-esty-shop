class Merchant < ApplicationRecord

  has_many :items
  has_many :invoices, through: :items

  def distinct_invoices
    invoices.distinct
  end

end
