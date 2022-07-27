class Invoice < ApplicationRecord
    enum status:[:'in progress', :cancelled, :completed]
  
  has_many :invoice_items
  has_many :items, through: :invoice_items

  validates_presence_of :status

  #merchants have items go on the invoice_items go to invoices!
  #merchant has many items 
  #the items belong to many invoice_items
  #filter item table select items that only have the merchant id 


  def merchant_invoice_by_id(merchant_id)
    require 'pry'; binding.pry
    InvoiceItems.joins(:items)
    # Playlist.where(theme: myGivenTheme).joins(tracks: :answers).where(answers:{status: true, user_id: self.id})
    
  end
end
