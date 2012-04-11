class UsersController < ApplicationController

  before_filter :authenticate_user!


  def index
    @users = current_user.watchings.joins(:owner).select('users.id, users.username, COUNT(repos.id) AS repos').
                                    page(params[:page]).group(:owner_id, 'users.id', 'users.username').
                                    order(params[:order] ||= 'username ASC')
  end

  def show
    @repos = current_user.watchings.where('users.username' => params[:id]).page(params[:page]).
                                    includes(:owner).order(params[:order] ||= 'repos.watchers_count DESC')
  end

end