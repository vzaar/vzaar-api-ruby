require "spec_helper"

describe Vzaar::Resource::User do
  let(:xml) do
    <<-XML
      <?xml version="1.0" encoding="UTF-8"?>
        <user>
          <version>1.0</version>
          <author_name>exampleuserbob</author_name>
          <author_id>44</author_id>
          <author_url>http://vzaar.com/users/exampleuserbob</author_url>
          <author_account>3</author_account>
          <author_account_title>Free</author_account_title>
          <created_at>2007-07-12T11:30:13+00:00</created_at>
          <video_count>127</video_count>
          <play_count>5188</play_count>
          <bandwidth_this_month>97123912</bandwidth_this_month>
            <bandwidth>
              <period month="3" year="2014">97123912</period>
              <period month="#{month}" year="#{year}">#{value}</period>
            </bandwidth>
          <videos_total_size>6601764</videos_total_size>
        </user>
    XML
  end

  let(:month) { 3 }
  let(:year) { 2014 }
  let(:value) { 34222572 }

  subject { described_class.new(Nokogiri::XML(xml)) }

  describe "bandwidth node" do
    before { @bw = subject.bandwidth.last }

    specify { expect(@bw.year).to eq(year) }
    specify { expect(@bw.month).to eq(month) }
    specify { expect(@bw.value).to eq(value) }
  end
end
