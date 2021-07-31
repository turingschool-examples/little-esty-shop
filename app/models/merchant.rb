class Merchant < ApplicationRecord
  has_many :items

  def enable
    merchant = Merchant.find(params[:id])
    merchant.status = true
  end

  def disable
    merchant = Merchant.find(params[:id])
    merchant.status = false
  end
end
