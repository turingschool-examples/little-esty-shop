class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items

  def merchant_items
    items.all
  end
end
