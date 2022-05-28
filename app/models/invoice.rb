class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions, dependent: :destroy
end