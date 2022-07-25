class Invoice < ApplicationRecord
  validates_presence_of :status
end
