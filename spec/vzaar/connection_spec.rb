require 'spec_helper'

module Vzaar
  describe Connection do
    let(:params) { { server: server } }

    subject { described_class.new params }

    describe "#server" do
      context "when server params includes http protocol" do
        let(:server) { "http://example.com" }
        specify { expect(subject.server).to eq("example.com") }
      end

      context "when server params includes https protocol" do
        let(:server) { "https://example.com" }
        specify { expect(subject.server).to eq("example.com") }
      end

      context "when server param is blank" do
        let(:server) { nil }
        specify { expect(subject.server).to eq(described_class::SERVER) }
      end
    end
  end
end
