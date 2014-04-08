require 'spec_helper'

module Vzaar::Response
  describe UserDetails do

    subject { described_class.new xml }

    context "when xml is returned" do
      let(:version) { '1.0' }
      let(:author_name) { 'api-test-user' }
      let(:author_id) { '93721' }
      let(:author_url) { 'http://vzaar.com/users/api-test-user' }
      let(:author_account) { '34' }
      let(:author_account_title) { 'Staff' }
      let(:created_at) { '2012-12-17T16:41:26+00:00' }
      let(:video_count) { '32' }
      let(:play_count) { '1317' }
      let(:max_file_size) { '10737418240' }

      let(:xml) do
        <<-XML
          <?xml version="1.0" encoding="UTF-8"?>
          <user>
            <version>#{version}</version>
            <author_name>#{author_name}</author_name>
            <author_id>#{author_id}</author_id>
            <author_url>#{author_url}</author_url>
            <author_account>#{author_account}</author_account>
            <author_account_title>#{author_account_title}</author_account_title>
            <created_at>#{created_at}</created_at>
            <video_count>#{video_count}</video_count>
            <play_count>#{play_count}</play_count>
            <max_file_size>#{max_file_size}</max_file_size>
          </user>
        XML
      end

      its(:version) { should eq(version) }
      its(:author_name) { should eq(author_name) }
      its(:name) { should eq(author_name) }
      its(:author_id) { should eq(author_id) }
      its(:id) { should eq(author_id) }
      its(:author_url) { should eq(author_url) }
      its(:url) { should eq(author_url) }
      its(:author_account) { should eq(author_account) }
      its(:account_type_id) { should eq(author_account) }
      its(:account_type_name) { should eq(author_account_title) }
      its(:created_at) { should eq(created_at) }
      its(:video_count) { should eq(video_count) }
      its(:play_count) { should eq(play_count) }
      its(:max_file_size) { should eq(max_file_size) }
    end

    context "when xml is nil" do
      let(:xml) { nil }

      its(:version) { should be_empty }
      its(:author_name) { should be_empty }
      its(:name) { should be_empty }
      its(:author_id) { should be_empty }
      its(:id) { should be_empty }
      its(:author_url) { should be_empty }
      its(:url) { should be_empty }
      its(:author_account) { should be_empty }
      its(:account_type_id) { should be_empty }
      its(:account_type_name) { should be_empty }
      its(:created_at) { should be_empty }
      its(:video_count) { should be_empty }
      its(:play_count) { should be_empty }
      its(:max_file_size) { should be_empty }
    end

  end
end
