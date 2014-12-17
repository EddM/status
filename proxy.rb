require "sinatra"
require "json"

configure do
  Dir.mkdir("#{settings.root}/log") unless File.exist?("#{settings.root}/log")
  file = File.new("#{settings.root}/log/#{settings.environment}.log", "a+")
  file.sync = true
  use Rack::CommonLogger, file
end

post "/builds" do
  logger.warn params.inspect
  logger.warn JSON.parse(request.body.read)
  payload_data = JSON.parse(params[:payload])
end
