class Transaction < ApplicationRecord
  belongs_to :invoice

  enum result: [ :success, :failed ]
#  enum status: { active: 0, archived: 1 }

end
