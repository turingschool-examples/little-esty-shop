class Merchant < ApplicationRecord 
  has_many :items
  has_many :invoices, :through => :items, dependent: :destroy
  
  def pending_invoices
    Merchant.joins(:invoices).where("merchants.id = #{self.id}").where('invoices.status = 1')
    #invoices
  end
end