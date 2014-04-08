require 'spec_helper'

module Vzaar::Response
  describe VideoDetails do

    subject { described_class.new video_id, xml }
    let(:video_id) { '1403915' }

    context "when xml is returned" do
      let(:type) { 'video' }
      let(:version) { '1.0' }
      let(:title) { 'ej-xshiz-1.flv' }
      let(:description) { 'A very interesting description.' }
      let(:author_name) { 'api-test-user' }
      let(:author_url) { 'http://vzaar.com/users/api-test-user' }
      let(:author_account) { '34' }
      let(:provider_name) { 'vzaar' }
      let(:provider_url) { 'http://vzaar.com' }
      let(:video_url) { 'http://view.vzaar.com/1403915/video' }
      let(:thumbnail_url) { 'http://view.vzaar.com/1403915/thumb' }
      let(:thumbnail_width) { '120' }
      let(:thumbnail_height) { '90' }
      let(:framegrab_url) { 'http://view.vzaar.com/1403915/image' }
      let(:framegrab_width) { '320' }
      let(:framegrab_height) { '256' }
      let(:html) { '<iframe allowFullScreen allowTransparency="true" class="vzaar-video-player" frameborder="0" height="256" id="vzvd-1403915" mozallowfullscreen name="vzvd-1403915" src="//view.vzaar.com/1403915/player" title="vzaar video player" type="text/html" webkitAllowFullScreen width="320"></iframe>' }
      let(:height) { '256' }
      let(:width) { '320' }
      let(:duration) { '16.92' }
      let(:video_status_id) { '2' }
      let(:video_status_description) { 'Active' }
      let(:play_count) { '0' }


      let(:xml) do
        <<-XML
          <?xml version="1.0" encoding="utf-8" standalone="yes"?>
          <oembed>
            <type>#{type}</type>
            <version>#{version}</version>
            <title>#{title}</title>
            <description>#{description}</description>
            <author_name>#{author_name}</author_name>
            <author_url>#{author_url}</author_url>
            <author_account>#{author_account}</author_account>
            <provider_name>#{provider_name}</provider_name>
            <provider_url>#{provider_url}</provider_url>
            <video_url>#{video_url}</video_url>
            <thumbnail_url>#{thumbnail_url}</thumbnail_url>
            <thumbnail_width>#{thumbnail_width}</thumbnail_width>
            <thumbnail_height>#{thumbnail_height}</thumbnail_height>
            <framegrab_url>#{framegrab_url}</framegrab_url>
            <framegrab_width>#{framegrab_width}</framegrab_width>
            <framegrab_height>#{framegrab_height}</framegrab_height>
            <html><![CDATA[#{html}]]></html>
            <height>#{height}</height>
            <width>#{width}</width>
            <duration>#{duration}</duration>
            <video_status_id>#{video_status_id}</video_status_id>
            <video_status_description>#{video_status_description}</video_status_description>
            <play_count>#{play_count}</play_count>
          </oembed>
        XML
      end

      its(:id) { should eq(video_id) }
      its(:type) { should eq(type) }
      its(:version) { should eq(version) }
      its(:title) { should eq(title) }
      its(:description) { should eq(description) }
      its(:author_name) { should eq(author_name) }
      its(:user_name) { should eq(author_name) }
      its(:author_url) { should eq(author_url) }
      its(:user_url) { should eq(author_url) }
      its(:author_account) { should eq(author_account) }
      its(:user_account_type_id) { should eq(author_account) }
      its(:provider_name) { should eq(provider_name) }
      its(:provider_url) { should eq(provider_url) }
      its(:video_url) { should eq(video_url) }
      its(:thumbnail_url) { should eq(thumbnail_url) }
      its(:thumbnail_width) { should eq(thumbnail_width) }
      its(:thumbnail_height) { should eq(thumbnail_height) }
      its(:framegrab_url) { should eq(framegrab_url) }
      its(:framegrab_width) { should eq(framegrab_width) }
      its(:framegrab_height) { should eq(framegrab_height) }
      its(:html) { should eq(html) }
      its(:height) { should eq(height) }
      its(:width) { should eq(width) }
      its(:duration) { should eq(duration) }
      its(:video_status_id) { should eq(video_status_id) }
      its(:video_status_description) { should eq(video_status_description) }
      its(:play_count) { should eq(play_count) }
    end

    context "when xml is nil" do
      let(:xml) { nil }

      its(:id) { should eq(video_id) }
      its(:type) { should be_empty }
      its(:version) { should be_empty }
      its(:title) { should be_empty }
      its(:description) { should be_empty }
      its(:author_name) { should be_empty }
      its(:user_name) { should be_empty }
      its(:author_url) { should be_empty }
      its(:user_url) { should be_empty }
      its(:author_account) { should be_empty }
      its(:user_account_type_id) { should be_empty }
      its(:provider_name) { should be_empty }
      its(:provider_url) { should be_empty }
      its(:video_url) { should be_empty }
      its(:thumbnail_url) { should be_empty }
      its(:thumbnail_width) { should be_empty }
      its(:thumbnail_height) { should be_empty }
      its(:framegrab_url) { should be_empty }
      its(:framegrab_width) { should be_empty }
      its(:framegrab_height) { should be_empty }
      its(:html) { should be_empty }
      its(:height) { should be_empty }
      its(:width) { should be_empty }
      its(:duration) { should be_empty }
      its(:video_status_id) { should be_empty }
      its(:video_status_description) { should be_empty }
      its(:play_count) { should be_empty }
    end

  end
end
