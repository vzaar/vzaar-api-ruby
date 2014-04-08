require 'spec_helper'

module Vzaar
  describe Connection do
    let(:params) { { server: server } }

    subject { described_class.new params }

    describe "#initialize" do
      context "when server params includes http protocol" do
        let(:server) { "http://example.com" }
        its(:server) { should eq "example.com" }
      end

      context "when server params includes https protocol" do
        let(:server) { "https://example.com" }
        its(:server) { should eq "example.com" }
      end
    end
  end
end
