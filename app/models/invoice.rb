class Invoice < ApplicationRecord
  validates_presence_of :status
  belongs_to :customer
end
