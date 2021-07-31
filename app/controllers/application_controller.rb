class ApplicationController < ActionController::Base
end

private

def error_message(errors)
  errors.full_messages.join(', ')
end