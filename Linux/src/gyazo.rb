#!/usr/bin/env ruby

# setting
browser_cmd = 'xdg-open'
clipboard_cmd = 'xclip'

require 'net/http'
require "rexml/document"
require 'json'

# get id
idfile = ENV['HOME'] + "/.gyazo.id"

id = '3e7a4deb7ac67da'


# capture png file
tmpfile = "/tmp/image_upload#{$$}.png"
imagefile = ARGV[0]

if imagefile && File.exist?(imagefile) then
  system "convert '#{imagefile}' '#{tmpfile}'"
else
  system "import '#{tmpfile}'"
end

if !File.exist?(tmpfile) then
  exit
end

imagedata = File.read(tmpfile)
File.delete(tmpfile)

# upload
boundary = '----BOUNDARYBOUNDARY----'

HOST = 'api.imgur.com'
CGI = '/3/upload'
UA   = 'curl/7.30.0'

data = <<EOF
--#{boundary}\r
content-disposition: form-data; name="key"\r
\r
#{id}\r
--#{boundary}\r
content-disposition: form-data; name="image"; filename="imgur.com"\r
Content-type: "image/png"\r
\r
#{imagedata}\r
--#{boundary}--\r
EOF

header ={
  'Content-Length' => data.length.to_s,
  'Content-type' => "multipart/form-data; boundary=#{boundary}",
  'User-Agent' => UA,
  'Authorization' => "Client-ID #{id}"
}

env = ENV['http_proxy']
if env then
  uri = URI(env)
  proxy_host, proxy_port = uri.host, uri.port
else
  proxy_host, proxy_port = nil, nil
end

http = Net::HTTP.new(HOST, 443)
http.use_ssl = true
res = http.post(CGI,data,header)
url = res.response.body

doc = doc = JSON.parse(url)
    
orig_image = "https://i.imgur.com/#{doc["data"]["id"]}.png"
delete_url = "https://i.imgur.com/delete/#{doc["data"]["deletehash"]}.png"

#thumb = doc.elements['rsp'].elements['small_thumbnail'].text

  if system "which #{clipboard_cmd} >/dev/null 2>&1" then
    system "echo -n '#{orig_image}' | #{clipboard_cmd}"
  end
  system "#{browser_cmd} '#{orig_image}' &"
    system "echo \"<div style='padding:10px;width:250px;height:275px;float:left'><a href='#{orig_image}'><img src='#{tmpfile}' height=250 width=250></img></a><button style='width:250px;height:25px' onclick=javascript:location.href='#{delete_url}'> delete  </button></div>\" >> ~/Documents/imgyazo.html"

