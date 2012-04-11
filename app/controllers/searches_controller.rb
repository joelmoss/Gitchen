class SearchesController < ApplicationController

  before_filter :authenticate_user!


  def index
    params[:per_page] ||= 20
    params[:page] ||= 1
    order = params[:order] ||= 'watchers_count DESC'

    search = Tire::Search::Search.new(GITCHEN_INDEX_NAME, :type => :watch, :query => params[:q])
    search.size params[:per_page]
    search.from params[:page].to_i <= 1 ? 0 : (params[:per_page].to_i * (params[:page].to_i-1))
    search.filter :terms, watcher_id: [ current_user.id ]
    search.sort do
      field_name, direction = order.split(' ')
      by field_name.to_sym, direction.downcase
    end

    @repos = search.results
  end

end
