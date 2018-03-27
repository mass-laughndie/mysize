=begin
if ENV['RACK_ENV'] == 'production'
  MyAppName::Application.config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
    r301 %r{.*}, 'https://www.mysize-sneakers.com$&', :if => Proc.new { |rack_env|
      rack_env['SERVER_NAME'] == 'mysize1.herokuapp.com'
    }
  end
end
=end