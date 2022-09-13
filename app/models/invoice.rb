class Invoice < ApplicationRecord
  enum status: { cancelled: 0, in_progress: 1, completed: 2 }
end
