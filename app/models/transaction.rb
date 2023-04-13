class Transaction < ApplicationRecord
  belongs_to :invoice

  enum result: [:failed, :success]
end
