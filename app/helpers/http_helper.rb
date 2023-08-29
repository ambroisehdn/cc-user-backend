require 'net/http'
require 'json'

module HttpHelper
  extend ActiveSupport::Concern
    
  def make_get_request(url)
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)

    http.request(request)
  end

  def make_post_request(url, params)
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri)
    request['Content-Type'] = 'application/json'
    request.body = params.to_json

    http.request(request)
  end
end
