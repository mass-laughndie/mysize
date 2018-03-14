class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :set_request_from


  private

    #初回でnameを入力せずに他のページに飛ぼうとした場合
    def no_name
      if logged_in? && current_user.name.nil?
        flash[:danger] = "ユーザー名を登録してください"
        redirect_to(welcome_path)
      end
    end

    #ログイン済みユーザーか確認
    def logged_in_user
      #ログインしていない場合
      unless logged_in?
        #遷移先URLをsessionに一時保存
        store_location
        #dangerフラッシュを表示
        flash[:danger] = "ログインしてください！"
        #login画面へリダイレクト
        #login_「url」なのは/loginの前に余計なurlがある可能性があり完全なurlで誘導するため
        redirect_to login_url
      end
    end

    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end

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
