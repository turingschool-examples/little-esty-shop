class Item < ApplicationRecord
  has_many :invoice_items
  belongs_to :merchant

  def self.find_item(id)
    find(id)
  end

end
