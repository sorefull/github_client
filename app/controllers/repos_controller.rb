class ReposController < ApplicationController
  before_action :authenticate_user!, only: :like

  def index
    params['name'] ||= 'trailblazer'
    url = Github.search('repositories', params['name'])
    response = HTTParty.get(url)
    @repos = response.parsed_response
  end

  def show
    params['reponame'] ||= 'trailblazer/trailblazer'
    url = Github.show('repos', params['reponame'])
    response = HTTParty.get(url)
    @repo = response.parsed_response
    if check_rate_of_limit(@repo)
      @repo['contributors'] = HTTParty.get(@repo['contributors_url']+"?#{Github.envs}").parsed_response
      @likes = Like.where(name: params['reponame'])
    end
  end

  def like
    current_user.likes.create(name: params['reponame'])
    @likes = Like.where(name: params['reponame'])
    render partial: 'likes/likes'
  end
end
