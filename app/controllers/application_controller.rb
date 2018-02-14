class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

    #初回でnameを入力せずに他のページに飛ぼうとした場合
    def no_name
      if current_user.name.nil?
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
end
