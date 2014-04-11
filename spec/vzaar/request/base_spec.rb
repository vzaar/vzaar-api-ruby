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
        expect(subject.authenticated).to be_true
      end
    end
  end
end
