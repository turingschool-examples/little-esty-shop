class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy

  validates :name, presence: true


  def five_best_customers

  end
end
