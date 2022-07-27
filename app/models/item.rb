class Item < ApplicationRecord
    belongs_to :merchant
    enum status:[:disabled, :enabled]
end
