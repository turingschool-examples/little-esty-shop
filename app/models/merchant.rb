class Merchant < ApplicationRecord

  has_many :items

  def invoices
    Invoice.joins(:items).where("items.merchant_id = #{id}").distinct
  end

end
