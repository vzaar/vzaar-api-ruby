require 'spec_helper'
require './lib/vzaar/request/process_video'

describe Vzaar::Request::ProcessVideo do
  subject { described_class.new nil, opts }

  describe "#get_opts" do
    context "when options received are missing guid" do
      let(:opts) { {} }

      it "should raise an exception" do
        expect { subject.send(:get_opts) }.to raise_error Vzaar::Error, "Guid required to process video."
      end
    end

    shared_examples "options have the guid" do
      it "should format the hash" do
        expect(subject.send(:get_opts)).to eq(expected_opts)
      end
    end

    context "when options received contain the guid" do
      let(:opts) { { guid: "testguid", title: "sometitle" } }
      let(:expected_opts) { { vzaar_api: { video: opts } } }

      it_behaves_like "options have the guid"
    end

    context "when options have guid and encoding information" do
      let(:opts) { { guid: "testguid", title: "sometitle", profile: 6, width: 10, bitrate: 20 } }
      let(:expected_opts) { { vzaar_api: { video: { guid: "testguid", title: "sometitle", profile: 6, encoding: { width: 10, bitrate: 20 } } } } }

      it_behaves_like "options have the guid"
    end
  end
end
