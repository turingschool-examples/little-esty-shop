class Item < ApplicationRecord
  self.primary_key = :id

  belongs_to :merchant
end
