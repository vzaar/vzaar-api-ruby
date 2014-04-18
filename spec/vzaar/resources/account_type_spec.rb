require "spec_helper"

module Vzaar::Resource
  describe AccountType do
    let(:version) { 1.0 }
    let(:account_id) { 40 }
    let(:title) { "title" }
    let(:monthly) { 10 }
    let(:currency) { "$" }
    let(:bandwidth) { 23423 }
    let(:borderless) { true }
    let(:search_enhancer) { false }

    let(:xml) do
      "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<account>\n <version>#{version}</version>\n <account_id>#{account_id}</account_id>\n <title>#{title}</title>\n <cost>\n  <monthly>#{monthly}</monthly>\n  <currency>#{currency}</currency>\n </cost>\n <bandwidth>#{bandwidth}</bandwidth>\n <rights>\n  <borderless>#{borderless}</borderless>\n  <searchEnhancer>#{search_enhancer}</searchEnhancer>\n </rights>\n</account>\n"
    end

    subject { described_class.new(xml) }

    its(:api_version) { should eq(version) }
    its(:id) { should eq(account_id) }
    its(:title) { should eq(title) }
    its(:monthly) { should eq(monthly) }
    its(:currency) { should eq(currency) }
    its(:bandwidth) { should eq(bandwidth) }
    its(:search_enhancer) { should eq(search_enhancer) }
    its(:borderless) { should eq(borderless) }
  end
end
