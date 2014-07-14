require_relative './spec_helper'

describe "Video Details" do
  context "Fully Protected API" do
    it_behaves_like "Unauthenticated", -> (api) do
      api.video_details(test_video_id("user1"))
    end
  end

  context "Public API" do
    before(:all) do
      api = unauthenticated_api
      @res = api.video_details(test_video_id("user_with_public_api"))
    end

    it_behaves_like "200 OK"
  end

  context "Protected API with access for public videos" do
    scope = api_envs[env]["user_with_public_videos_access_only"]

    context "when video is public" do
      before do
        api = unauthenticated_api
        @res = api.video_details(scope["test_public_video_id"])
      end

      it_behaves_like "200 OK"
    end

    context "when video is private" do
      it_behaves_like "Unauthenticated", -> (api) do
        api.video_details(scope["test_video_id"])
      end
    end
  end
end
