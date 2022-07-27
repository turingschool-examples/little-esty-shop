class ApplicationController < ActionController::Base
    def welcome
    end

    def error_message(errors)
        errors.full_messages.join(', ')
      end
end
