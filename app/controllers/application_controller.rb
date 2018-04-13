class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :set_request_from


  private

    def logged_in_user
      unless logged_in?
        store_location                        #遷移先URLをsessionに一時保存
        flash[:danger] = "ログインしてください！"
        redirect_to login_url
      end
    end

    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end

    #
    def set_request_from
      if session[:request_from]
        @request_from = session[:request_from]
      end
      session[:request_from] = request.original_url
    end

    def return_back
      if request.referer
        redirect_back(fallback_location: root_url)
      elsif @request_from
        redirect_to @request_from
      end
    end

    def that_week(time)
      time.beginning_of_week..time.end_of_week
    end

    def that_day(time)
      time.all_day
    end

end
