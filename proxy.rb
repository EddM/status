require "sinatra"
require "sinatra/config_file"
require "json"

config_file "config.yml"

configure do
  Dir.mkdir("#{settings.root}/log") unless File.exist?("#{settings.root}/log")
  file = File.new("#{settings.root}/log/#{settings.environment}.log", "a+")
  file.sync = true
  use Rack::CommonLogger, file
end

post "/builds" do
  data = JSON.parse(request.body.read)

  if payload = data["payload"]
    if payload["branch"] == "master"
      if payload["outcome"] == "success"
        function_name = "setOK"
      elsif payload["outcome"] == "failed"
        function_name = "setError"
      else
        function_name = "setUnknown"
      end

      base_url = "https://api.spark.io/v1/devices/#{settings.device_id}"
      HTTParty.post("#{base_url}/#{function_name}", body: { "access_token" => settings.access_token })
    end
  end
end
