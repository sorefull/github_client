class ReposController < ApplicationController
  def index
    params['name'] ||= 'trailblazer'
    url = "https://api.github.com/search/repositories?q=#{params['name']}&client_id=#{ENV['github_client_id']}&client_secret=#{ENV['github_client_secret']}"
    response = HTTParty.get(url)
    @repos = response.parsed_response
  end

  def show
    params['reponame'] ||= 'trailblazer/trailblazer'
    url = "https://api.github.com/repos/#{params['reponame']}?client_id=#{ENV['github_client_id']}&client_secret=#{ENV['github_client_secret']}"
    response = HTTParty.get(url)
    @repo = response.parsed_response
    @repo['contributors'] = HTTParty.get(@repo['contributors_url']+"?client_id=#{ENV['github_client_id']}&client_secret=#{ENV['github_client_secret']}").parsed_response
  end
end
