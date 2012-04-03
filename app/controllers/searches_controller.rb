class SearchesController < ApplicationController
  
  def index
    @repos = Repo.search params[:q], page: params[:page], per_page: 20
  end
  
end
