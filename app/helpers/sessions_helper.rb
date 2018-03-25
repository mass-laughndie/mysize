module SessionsHelper

  def log_in(user)
    session[:msuid] = user.id
  end

  def remember(user)
    #remember_tokenを発行し、userのDBにrember_digest(tokenのハッシュ化)を保存
    user.remember
    #cookiesにidを保存
    cookies.permanent.signed[:msuid] = { value: user.id, httponly: true }
    #cookiesにremeber_tokenを保存
    cookies.permanent[:remember_token] = { value: user.remember_token, httponly: true }
  end

  def current_user?(user)
    user == current_user
  end

  def current_user
    if (msuid = session[:msuid])
      @current_user ||= User.find_by(id: msuid)
    elsif (msuid = cookies.signed[:msuid])
      user = User.find_by(id: msuid)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def forget(user)
    user.forget
    cookies.delete(:msuid)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:msuid)
    @current_user = nil
  end

  #記憶したURL(もしくはデフォルト値)にリダイレクト
  def redirect_back_or(default)
    #session[:forwarding_url]か=nilならdefaultのURLにリダイレクト
    redirect_to(session[:forwarding_url] || default)
    #session[:forwarding_url]の削除
    session.delete(:forwarding_url)
  end

  #アクセスしようとしたURLを覚えておく
  def store_location
    #request.get?:GETリクエストが送信されたらtrue
    #request.origin_url:リクエスト対象のURL
    #GETリクエストがあるURLに送られたらそのURLをsessionの:forwarding_urlキーに一時的に格納
    session[:forwarding_url] = request.original_url if request.get?
  end
  
end
