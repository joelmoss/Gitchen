class UsersController < ApplicationController

  before_filter :authenticate_user!


  def index
    @users = current_user.watchings.joins(:owner).select('users.username, COUNT(repos.id) AS repos').
                                    page(params[:page]).group(:owner_id).order('repos DESC, username')
  end

  def show
    @repos = current_user.watchings.where('users.username' => params[:id]).
                          page(params[:page]).includes(:owner).order('watchers_count DESC, name')
  end

end
