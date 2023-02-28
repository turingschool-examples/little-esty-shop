class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  enum status: {enabled: 0, disabled: 1}

  def self.create_new_item(item_params)
    create(item_params)
  end

end
