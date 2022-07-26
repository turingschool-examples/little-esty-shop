class Invoice < ApplicationRecord
    enum status:[:'in progress', :cancelled, :completed]
end
