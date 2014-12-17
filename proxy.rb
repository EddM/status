require "sinatra"
require "json"

post "/builds" do
  payload_data = JSON.parse(params[:payload])
end
