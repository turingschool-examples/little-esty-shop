class ApplicationController < ActionController::Base
  # def index
  #   token = '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'
  #   service = GitHubService.new(token)
  #   name = service.get_name[:name]
  # end

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
