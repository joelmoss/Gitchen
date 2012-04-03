class ReposController < ApplicationController
  
  before_filter :authenticate_user!
  
  
  def index
    @repos = current_user.watchings
  end
  
  def show
    @repo = current_user.watchings.find(params[:id])
  end
  
end
