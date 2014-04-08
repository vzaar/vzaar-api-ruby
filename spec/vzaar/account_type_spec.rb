require 'spec_helper'

module Vzaar
  describe AccountType do

    subject { described_class.new xml }

    context "when xml is returned" do
      let(:version) { '1.0' }
      let(:account_id) { '100' }
      let(:title) { 'Express' }
      let(:monthly) { '30' }
      let(:currency) { '$' }
      let(:bandwidth) { '107374182400' }
      let(:borderless) { 'true' }
      let(:search_enhancer) { 'true' }

      let(:xml) do
        <<-XML
          <?xml version="1.0" encoding="UTF-8"?>
          <account>
            <version>#{version}</version>
            <account_id>#{account_id}</account_id>
            <title>#{title}</title>
            <cost>
              <monthly>#{monthly}</monthly>
              <currency>#{currency}</currency>
            </cost>
            <bandwidth>#{bandwidth}</bandwidth>
            <rights>
              <borderless>#{borderless}</borderless>
              <searchEnhancer>#{search_enhancer}</searchEnhancer>
            </rights>
          </account>
        XML
      end

      its(:version) { should eq(version) }
      its(:account_id) { should eq(account_id) }
      its(:id) { should eq(account_id) }
      its(:title) { should eq(title) }
      its(:monthly) { should eq(monthly) }
      its(:currency) { should eq(currency) }
      its(:bandwidth) { should eq(bandwidth) }
      its(:borderless) { should eq(borderless) }
      its(:search_enhancer) { should eq(search_enhancer) }
    end

    context "when xml is nil" do
      let(:xml) { nil }

      its(:version) { should be_empty }
      its(:account_id) { should be_empty }
      its(:id) { should be_empty }
      its(:title) { should be_empty }
      its(:monthly) { should be_empty }
      its(:currency) { should be_empty }
      its(:bandwidth) { should be_empty }
      its(:borderless) { should be_empty }
      its(:search_enhancer) { should be_empty }
    end
  end
end
