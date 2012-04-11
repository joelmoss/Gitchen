class Kaminari::Helpers::Paginator
  def render(&block)
    yield self
    @output_buffer
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :signed_in?
  before_filter :get_repo_count, if: :signed_in?


  private

    def get_repo_count
      @repo_count = current_user.watchings.count
    end

    def current_user
      return nil unless session[:user_id]

      begin
        @current_user ||= User.find(session[:user_id])
      rescue ActiveRecord::RecordNotFound
        nil
      end
    end

    def signed_in?
      !current_user.nil?
    end

    def authenticate_user!
      unless signed_in?
        redirect_to sign_in_url, :alert => 'You need to sign in for access to this page.'
      end
    end

end
