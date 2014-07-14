require_relative './spec_helper'

describe "User Details" do
  context "when user is unauthenticated" do
    before(:all) do
      api = unauthenticated_api()
      @res = api.user_details(user1['login'])
    end

    it_behaves_like "200 OK"
  end
end
