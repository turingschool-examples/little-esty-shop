class ApplicationController < ActionController::Base
    
    def error_message(error)
        error.full_messages.join(', ')
    end
end
