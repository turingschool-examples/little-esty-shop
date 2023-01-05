class Merchant < ApplicationRecord 
  has_many :items
  has_many :invoices, :through => :items, dependent: :destroy
  
  def pending_invoices
    Invoice.joins(:merchants).where("merchants.id = #{self.id}").where('invoices.status = 1').distinct
  end
end