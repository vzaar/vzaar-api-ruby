module Vzaar
  class AccountType < Response::Base

    attr_reader :version, :account_id, :title, :monthly, :currency,
      :bandwidth, :borderless, :search_enhancer

    alias_method :id, :account_id

    def initialize(xml)
      super(xml)
      @version = extract_text('//account/version')
      @account_id = extract_text('//account/account_id')
      @title = extract_text('//account/title')
      @monthly = extract_text('//account/cost/monthly')
      @currency = extract_text('//account/cost/currency')
      @bandwidth = extract_text('//account/bandwidth')
      @borderless = extract_text('//account/rights/borderless')
      @search_enhancer = extract_text('//account/rights/searchEnhancer')
    end

  end
end
