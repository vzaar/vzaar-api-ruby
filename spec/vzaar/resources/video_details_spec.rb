require "spec_helper"

describe Vzaar::Resource::VideoDetails do
  let(:processing_xml) do
    <<-XML
      <?xml version="1.0" encoding="UTF-8"?>
        <vzaar-api></vzaar-api>
     XML
  end

  let(:transcoded_xml) do
    <<-XML
      <?xml version="1.0" encoding="UTF-8"?>
        <oembed></oembed>
     XML
  end

  describe "#new" do
    context "when video is not ready yet" do
      let(:xml_doc) { Nokogiri::XML(processing_xml) }

      it "creates Vzaar::Resource::VideoStatus instance" do
        allow(Vzaar::Resource::VideoStatus).to receive(:new).with(xml_doc)
        subject.new(xml_doc)
      end
    end

    context "when video has been encoded" do
      let(:xml_doc) { Nokogiri::XML(transcoded_xml) }

      it "creates Vzaar::Resource::Video instance" do
        allow(Vzaar::Resource::Video).to receive(:new).with(xml_doc)
        subject.new(xml_doc)
      end
    end
  end
end
