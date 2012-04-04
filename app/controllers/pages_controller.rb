class PagesController < ApplicationController

  layout 'home', only: :index

  def index
    redirect_to repos_url and return if signed_in?
  end

end