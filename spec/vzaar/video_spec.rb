require 'spec_helper'

module Vzaar
  describe Video do

    subject { described_class.new xml }

    context "when xml is returned" do
      let(:version) { '1.0' }
      let(:id) { '1403915' }
      let(:status) { 'Active' }
      let(:status_id) { '2' }
      let(:title) { 'ej-xshiz-1.flv' }
      let(:description) { 'A very interesting description.' }
      let(:created_at) { '2013-11-21T10:12:49+00:00' }
      let(:url) { 'http://view.vzaar.com/1403915/video' }
      let(:thumbnail_url) { 'http://view.vzaar.com/1403915/thumb' }
      let(:play_count) { '0' }
      let(:author_name) { 'api-test-user' }
      let(:author_url) { 'http://vzaar.com/users/api-test-user' }
      let(:author_account) { '34' }
      let(:video_count) { '32' }
      let(:duration) { '16.92' }
      let(:height) { '256' }
      let(:width) { '320' }

      let(:xml) do
        <<-XML
          <video>
            <version>#{version}</version>
            <id>#{id}</id>
            <status>#{status}</status>
            <status_id>#{status_id}</status_id>
            <title>#{title}</title>
            <description>#{description}</description>
            <created_at>#{created_at}</created_at>
            <url>#{url}</url>
            <thumbnail_url>#{thumbnail_url}</thumbnail_url>
            <play_count>#{play_count}</play_count>
            <user>
              <author_name>#{author_name}</author_name>
              <author_url>#{author_url}</author_url>
              <author_account>#{author_account}</author_account>
              <video_count>#{video_count}</video_count>
            </user>
            <duration>#{duration}</duration>
            <height>#{height}</height>
            <width>#{width}</width>
          </video>
        XML
      end

      its(:version) { should eq(version) }
      its(:id) { should eq(id) }
      its(:status) { should eq(status) }
      its(:status_id) { should eq(status_id) }
      its(:title) { should eq(title) }
      its(:description) { should eq(description) }
      its(:created_at) { should eq(created_at) }
      its(:url) { should eq(url) }
      its(:thumbnail_url) { should eq(thumbnail_url) }
      its(:play_count) { should eq(play_count) }
      its(:author_name) { should eq(author_name) }
      its(:user_name) { should eq(author_name) }
      its(:author_url) { should eq(author_url) }
      its(:user_url) { should eq(author_url) }
      its(:author_account) { should eq(author_account) }
      its(:user_account_type_id) { should eq(author_account) }
      its(:video_count) { should eq(video_count) }
      its(:user_video_count) { should eq(video_count) }
      its(:duration) { should eq(duration) }
      its(:height) { should eq(height) }
      its(:width) { should eq(width) }
    end

    context "when xml is nil" do
      let(:xml) { nil }

      its(:version) { should be_empty }
      its(:id) { should be_empty }
      its(:status) { should be_empty }
      its(:status_id) { should be_empty }
      its(:title) { should be_empty }
      its(:description) { should be_empty }
      its(:created_at) { should be_empty }
      its(:url) { should be_empty }
      its(:thumbnail_url) { should be_empty }
      its(:play_count) { should be_empty }
      its(:author_name) { should be_empty }
      its(:user_name) { should be_empty }
      its(:author_url) { should be_empty }
      its(:user_url) { should be_empty }
      its(:author_account) { should be_empty }
      its(:user_account_type_id) { should be_empty }
      its(:video_count) { should be_empty }
      its(:user_video_count) { should be_empty }
      its(:duration) { should be_empty }
      its(:height) { should be_empty }
      its(:width) { should be_empty }
    end

  end
end
