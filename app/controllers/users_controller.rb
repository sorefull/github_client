class UsersController < ApplicationController
  before_action :authenticate_user!, only: :like

  def index
    params['name'] ||= 'trailblazer'
    url = "https://api.github.com/search/users?q=#{params['name']}&client_id=#{ENV['github_client_id']}&client_secret=#{ENV['github_client_secret']}"
    response = HTTParty.get(url)
    @users = response.parsed_response
  end

  def show
    url = "https://api.github.com/users/#{params['username']}?client_id=#{ENV['github_client_id']}&client_secret=#{ENV['github_client_secret']}"
    @user = HTTParty.get(url).parsed_response
    @user['user_repos'] = HTTParty.get(@user['repos_url']+"?client_id=#{ENV['github_client_id']}&client_secret=#{ENV['github_client_secret']}").parsed_response
    @likes = Like.all.where(name: params['username'])
  end

  def like
    current_user.likes.create(name: params['username'])
    @likes = Like.where(name: params['username'])
    render partial: 'likes/likes'
  end
end
