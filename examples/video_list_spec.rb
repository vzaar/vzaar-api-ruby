require_relative './spec_helper'

describe "Video List" do
  context "when user is unauthenticated" do
    it_behaves_like "Unauthenticated", -> (api) do
      api.video_list(user1["login"])
    end


    context "when Public API Feeds is enabled" do
      before(:all) do
        api = unauthenticated_api
        @res = api.video_list(user_with_public_api["login"])
      end

      it_behaves_like "200 OK"
    end
  end
end
