require "spec_helper"

describe Vzaar::Resource::Video do
  let(:rendition_1_type) { "sd" }
  let(:rendition_1_status) { "finished" }
  let(:rendition_1_status_id) { 3 }

  let(:xml) do
    "<?xml version=\"1.0\" encoding=\"utf-8\" standalone=\"yes\"?>\n<oembed>\n <type>video</type>\n <version>1.0</version>\n <width>240</width>\n <height>244</height>\n <html>\n  <![CDATA[<iframe allowFullScreen allowTransparency=\"true\" class=\"vzaar-video-player\" frameborder=\"0\" height=\"244\" id=\"vzvd-2762728\" mozallowfullscreen name=\"vzvd-2762728\" src=\"//view.vzaar.com/2762728/player\" title=\"vzaar video player\" type=\"text/html\" webkitAllowFullScreen width=\"240\"></iframe>]]>\n </html>\n <video_status_id>2</video_status_id>\n <video_status_description>Transcoded</video_status_description>\n <play_count>0</play_count>\n <total_size>882076</total_size>\n <title>v1-prod</title>\n <description>xx</description>\n <author_name>cfx</author_name>\n <author_url>http://app.vzaar.com/users/cfx</author_url>\n <author_account>34</author_account>\n <provider_name>vzaar</provider_name>\n <provider_url>http://vzaar.com</provider_url>\n <video_url>https://view.vzaar.com/2762728/video</video_url>\n <thumbnail_url>https://view.vzaar.com/2762728/thumb</thumbnail_url>\n <thumbnail_width>120</thumbnail_width>\n <thumbnail_height>90</thumbnail_height>\n <framegrab_url>https://view.vzaar.com/2762728/image</framegrab_url>\n <framegrab_width>240</framegrab_width>\n <framegrab_height>244</framegrab_height>\n <duration>5.0</duration>\n <renditions>\n  <rendition>\n   <type>#{rendition_1_type}</type>\n   <status_id>#{rendition_1_status_id}</status_id>\n   <status>#{rendition_1_status}</status>\n  </rendition>\n  <rendition>\n   <type>hls</type>\n   <status_id>3</status_id>\n   <status>finished</status>\n  </rendition>\n </renditions>\n</oembed>\n"
  end

  subject { described_class.new(Nokogiri::XML(xml)) }

  describe "renditions" do
    before do
      @rendition_1 = subject.renditions.first
    end

    specify { expect(@rendition_1.type).to eq(rendition_1_type) }
    specify { expect(@rendition_1.status).to eq(rendition_1_status) }
    specify { expect(@rendition_1.status_id).to eq(rendition_1_status_id) }
  end
end
