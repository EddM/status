require "sinatra"
require "json"

configure do
  # logging is enabled by default in classic style applications,
  # so `enable :logging` is not needed
  file = File.new("#{settings.root}/log/#{settings.environment}.log", 'a+')
  file.sync = true
  use Rack::CommonLogger, file
end

post "/builds" do
  payload_data = JSON.parse(params[:payload])
end
