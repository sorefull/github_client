class UsersController < ApplicationController
  before_action :authenticate_user!, only: :like

  def index
    params['name'] ||= 'trailblazer'
    url = Github.search('users', params['name'])
    response = HTTParty.get(url)
    @users = response.parsed_response
  end

  def show
    url = Github.show('users', params['username'])
    @user = HTTParty.get(url).parsed_response
    if check_rate_of_limit(@user)
      @user['user_repos'] = HTTParty.get(@user['repos_url']+"?#{Github.envs}").parsed_response
      @likes = Like.all.where(name: params['username'])
    end
  end

  def like
    current_user.likes.create(name: params['username'])
    @likes = Like.where(name: params['username'])
    render partial: 'likes/likes'
  end
end
