class SearchesController < ApplicationController
  
  def index
    @repos = Repo.search params[:q], page: params[:page]
  end
  
end
