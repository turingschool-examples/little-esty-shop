class Invoice < ApplicationRecord
    enum status: [:completed, :in_progress, :cancelled]

    validates_presence_of :status
    validates_presence_of :created_at
    validates_presence_of :updated_at
end 