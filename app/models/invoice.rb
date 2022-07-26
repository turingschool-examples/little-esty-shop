class Invoice < ApplicationRecord
    enum status: {in_progress: 0, cancelled: 1, completed: 2}
    # default: :in_progess
end
