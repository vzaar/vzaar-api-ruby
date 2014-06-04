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

    specify { expect(subject.api_version).to eq(version) }
    specify { expect(subject.id).to eq(account_id) }
    specify { expect(subject.title).to eq(title) }
    specify { expect(subject.monthly).to eq(monthly) }
    specify { expect(subject.currency).to eq(currency) }
    specify { expect(subject.bandwidth).to eq(bandwidth) }
    specify { expect(subject.search_enhancer).to eq(search_enhancer) }
    specify { expect(subject.borderless).to eq(borderless) }
  end
end
