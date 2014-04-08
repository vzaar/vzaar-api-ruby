require 'spec_helper'

module Vzaar
  describe VideoCollection do

    subject { described_class.new xml }

    context "when xml is returned" do
      let(:xml) do
        <<-XML
          <?xml version="1.0" encoding="UTF-8"?>
          <videos>
            <video>
              <version>1.0</version>
              <id>1403915</id>
              <status>Active</status>
              <status_id>2</status_id>
              <title>ej-xshiz-1.flv</title>
              <description>A very interesting description.</description>
              <created_at>2013-11-21T10:12:49+00:00</created_at>
              <url>http://view.vzaar.com/1403915/video</url>
              <thumbnail_url>http://view.vzaar.com/1403915/thumb</thumbnail_url>
              <play_count>0</play_count>
              <user>
                <author_name>api-test-user</author_name>
                <author_url>http://vzaar.com/users/api-test-user</author_url>
                <author_account>34</author_account>
                <video_count>32</video_count>
              </user>
              <duration>16.92</duration>
              <height>256</height>
              <width>320</width>
            </video>
            <video>
              <version>1.0</version>
              <id>1403914</id>
              <status>Active</status>
              <status_id>2</status_id>
              <title>ej-xshiz-0.flv</title>
              <description>A very interesting description.</description>
              <created_at>2013-11-21T10:12:45+00:00</created_at>
              <url>http://view.vzaar.com/1403914/video</url>
              <thumbnail_url>http://view.vzaar.com/1403914/thumb</thumbnail_url>
              <play_count>0</play_count>
              <user>
                <author_name>api-test-user</author_name>
                <author_url>http://vzaar.com/users/api-test-user</author_url>
                <author_account>34</author_account>
                <video_count>32</video_count>
              </user>
              <duration>16.92</duration>
              <height>256</height>
              <width>320</width>
            </video>
          </videos>
        XML
      end

      its(:count) { should == 2 }

      describe "#each" do
        let(:ids) { %w( 1403914 1403915 ) }

        it "iterates over the internal collection of videos" do
          collected_ids = []
          subject.each do |video|
            collected_ids << video.id
          end
          expect(collected_ids).to match_array(ids)
        end
      end
    end

    context "when xml is nil" do
      let(:xml) { nil }

      its(:count) { should be_zero }
    end

  end
end
