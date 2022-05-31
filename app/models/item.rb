class Item < ApplicationRecord
  belongs_to :merchant

  enum status: [:disabled, :enabled]

  # def self.merchants_items_all
  #   binding.pry
  # end

end
