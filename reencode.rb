require_relative 'lib/vzaar_api'
require 'net/http'
require 'fileutils'


VzaarApi.hostname = 'app.vzaar.com'
VzaarApi.auth_token = 'xxxxxxxxxxx'
VzaarApi.client_id  = 'client_id'

videos.each do |video|
  top_rendition_name = video[:name]
  uri = URI(video[:download_url])

  printf "Downloading top rendition... "
  Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
    request = Net::HTTP::Get.new(uri.request_uri)

    http.request(request) do |response|
      open top_rendition_name, 'wb' do |io|
        response.read_body do |chunk|
          io.write chunk
        end
      end
    end
  end

  printf "Done\n"

  if File.exists?(top_rendition_name)
    printf "Replacing #{video[:id]}... "

    res = VzaarApi::Video.replace(
      ingest_recipe_id: 2,
      path: top_rendition_name,
      title: video[:title],
      description: video[:description],
      replace_id: video[:id]
    )
    printf "Done\n"

    printf "Deleting #{top_rendition_name}... "
    FileUtils.rm_rf(top_rendition_name)
    printf "Done\n" unless File.exists?(top_rendition_name)
  end
  printf  "---------------------------------------------------\n"
end
