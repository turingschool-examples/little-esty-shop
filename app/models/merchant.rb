class Merchant < ApplicationRecord
  has_many :items
  validates :name, presence: true

  def filter_item_status(status_enum)
    items.where(status: status_enum)
  end
end
