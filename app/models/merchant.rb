class Merchant < ApplicationRecord
  has_many :items
  validates :name, presence: true
end

#though methods are supposed to be public by default, for some reason these are private unless specified public. not sure why that is.
public
def enabled_items
  items.where(enabled: true)
end

def disabled_items
  items.where(enabled: false)
end



