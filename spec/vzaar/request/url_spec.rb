require 'spec_helper'
require './lib/vzaar/request/url'

describe Vzaar::Request::Url do
  let(:params) do
    { foo: 1, bar: 2 }
  end

  let(:format) { :xml }

  let(:url) { "/api/endpoint" }

  subject { described_class.new(url, format, params) }

  describe "#build" do
    context "when there are params" do
      specify { expect(subject.build).to eq("/api/endpoint.xml?foo=1&bar=2") }
    end

    context "when there are params" do
      let(:params) {{}}
      specify { expect(subject.build).to eq("/api/endpoint.xml") }
    end
  end
end
