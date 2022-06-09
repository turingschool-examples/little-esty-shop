# class ApplicationController < ActionController::Base
#   before_action :repo_info, only: %i[index show new edit]
#   # before_action :contributor_info, only: %i[index show new edit]
#   # before_action :merge_info, only: %i[index show new edit]
#   # before_action :commit_info, only: %i[index show new edit]
#   # gives every crud controller this instance variable
#   def repo_info
#     @repo = RepositoryFacade.repo_or_error
#     @contributor = RepositoryFacade.contributor_or_error
#     @merge = RepositoryFacade.merged_or_error
#     @commit = RepositoryFacade.commit_or_error
#   end
#
#   def contributor_info
#   end
#
#   def merge_info
#   end
#
#   def commit_info
#   end
# end
