class Item < ApplicationRecord
  belongs_to :merchant

  enum enabled: {enabled: 0, disabled: 1}
end
