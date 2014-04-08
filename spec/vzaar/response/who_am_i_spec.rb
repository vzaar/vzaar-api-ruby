require 'spec_helper'

module Vzaar::Response
  describe WhoAmI do

    subject { described_class.new xml }

    context "when xml is returned" do
      let(:login) { 'api-test-user' }

      let(:xml) do
        <<-XML
          <?xml version="1.0" encoding="UTF-8"?>
          <vzaar-api>
            <test>
              <login>#{login}</login>
            </test>
          </vzaar-api>
        XML
      end

      its(:body) { should eq(login) }
    end

    context "when xml is nil" do
      let(:xml) { nil }
      its(:body) { should be_empty }
    end

  end
end
