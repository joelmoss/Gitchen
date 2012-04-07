class SearchesController < ApplicationController

  before_filter :authenticate_user!


  def index
    @repos = Watch.search params[:q], page: params[:page], per_page: 20,
                                      filter: { term: { watcher_id: current_user.id } }
  end

end
