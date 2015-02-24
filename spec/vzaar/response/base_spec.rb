require 'spec_helper'

describe Vzaar::Response::Base do
  let(:body) do
    '<?xml version="1.0" encoding="UTF-8"?><vzaar-api><errors><foo>bar</foo></errors></vzaar-api>'
  end

  let(:res) do
    double(body: body)
  end

  let(:resource_name) { :foo }

  class Foo; end

  subject { described_class.new(res, resource_name) }

  describe "#resource" do
    context "when xml" do
      specify do
        allow(subject).to receive(:xml?) { true }
        allow(Foo).to receive(:new).with(subject.xml_doc)
        subject.resource
      end
    end

    context "when json" do
      let(:body) { "{}" }

      specify do
        allow(subject).to receive(:xml?) { false }
        allow(JSON).to receive(:parse).with(body)
        subject.resource
      end
    end
  end

  describe "mapping 'errors' xml node to ruby objects" do
    context "when xml" do
      before do
        allow(subject).to receive(:xml?) { true }
        @errors = subject.errors
      end

      specify { expect(@errors.first["foo"]).to eq("bar") }
    end

    context "when not xml" do
      before do
        allow(subject).to receive(:xml?) { false }
        @errors = subject.errors
      end
      specify { expect(@errors).to be_empty }
    end
  end
end
