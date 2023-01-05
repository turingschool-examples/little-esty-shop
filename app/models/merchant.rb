class Merchant < ApplicationRecord 
  has_many :items
  has_many :invoices, :through => :items, dependent: :destroy
  
  def packaged_items
    # select items where merchant_id = self.id 
  end
end