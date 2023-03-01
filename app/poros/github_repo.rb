require 'json'
require 'pry'
require_relative 'repo_search'

repo_name = RepoSearch.repo_name

p "Repo Name: #{repo_name.repo_name}"