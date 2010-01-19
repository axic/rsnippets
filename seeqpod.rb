# SeeqPod Ruby API
#
# (C) 2009 Alex Beregszaszi
#
# $MIT License$

require 'net/http'
require 'cgi'
require 'hmac-sha1' # ruby-hmac.gem

class SeeqPod
  def initialize(uid, key)
    raise Exception.new("UID and KEY are mandatory") if uid == nil or key == nil

    @uid = uid
    @key = key
  end

  def search(searchstring)
    query = "/api/v0.2/music/search/#{CGI.escape(searchstring)}"
    timestamp = Time.now.to_i.to_s

    request = Net::HTTP::Get.new(query)
    request.add_field("Seeqpod-uid", @uid)
    request.add_field("Seeqpod-timestamp", timestamp)
    request.add_field("Seeqpod-call-signature", HMAC::SHA1.hexdigest(@key, "#{query}#{timestamp}"))
    response = Net::HTTP.new("www.seeqpod.com", 80).start { |http| http.request(request) }
    # error handling
    response.body
  end
end
