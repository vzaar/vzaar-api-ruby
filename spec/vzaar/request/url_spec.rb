require 'spec_helper'
require './lib/vzaar/request/url'

describe Vzaar::Request::Url do
  let(:format) { :xml }
  let(:url) { "/api/endpoint" }

  subject { described_class.new(url, format, params) }

  describe "#build" do
    let(:result) { subject.build }

    context "when there are params" do
      let(:params) { { foo: 1, bar: 2 } }
      let(:expected_result) { "/api/endpoint.xml?foo=1&bar=2" }
      specify { expect(result).to eq expected_result }

      context 'and the params contain an unescaped ampersand' do
        let(:params) { { foo: 'this & that.mp4', bar: 2 } }
        let(:encoded_params) { URI.encode_www_form params }
        let(:expected_result) { "/api/endpoint.xml?#{encoded_params}" }
        specify { expect(result).to eq expected_result }
      end
    end

    context "when there are params" do
      let(:params) {{}}
      let(:expected_result) { "/api/endpoint.xml" }
      specify { expect(result).to eq expected_result }
    end
  end
end
