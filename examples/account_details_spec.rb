require_relative './spec_helper'

describe "Account Details" do
  context "when user is unauthenticated" do
    before(:all) do
      api = unauthenticated_api()
      @res = api.account_type(34)
    end

    it_behaves_like "200 OK"
    specify { expect(@res.title).to eq("Staff") }
  end
end
