class SearchesController < ApplicationController
  
  before_filter :authenticate_user!
  
  
  def index
    @repos = current_user.watchings.search params[:q], page: params[:page], per_page: 20
  end
  
end
