require 'spec_helper'
require './lib/vzaar/request/url'

describe Vzaar::Request::Base do
  let(:conn) { double }
  let(:opts) { { authenticated: authenticated? } }

  after do
    Object.send(:remove_const, "TestClass")
  end

  subject { TestClass.new(conn, opts) }

  describe "Object#authenticated" do
    context "when user provides the param" do
      let(:authenticated?) { true }

      before do
        class TestClass < Vzaar::Request::Base; end
      end

      it "overwites setting with param from options" do
        expect(subject.authenticated).to eq(opts[:authenticated])
      end
    end

    context "when setting is defined within the class" do
      let(:authenticated?) { false }

      before do
        class TestClass < Vzaar::Request::Base
          authenticated true
        end
      end

      specify do
        expect(subject.authenticated).to be_truthy
      end
    end
  end

  describe "Object#endpoint" do
    let(:opts) {{}}

    context "when param is not a function" do
      before do
        class TestClass < Vzaar::Request::Base
          endpoint "/api/endpoint"
        end
      end

      specify { expect(subject.endpoint).to eq("/api/endpoint") }
    end

    context "when param is a function" do
      before do
        class TestClass < Vzaar::Request::Base
          endpoint { |o| "/api/endpoint/#{o.param}" }
          def param; "cfx" end
        end
      end

      specify { expect(subject.endpoint).to eq("/api/endpoint/cfx") }
    end
  end
end
