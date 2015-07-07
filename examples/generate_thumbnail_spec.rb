require_relative './spec_helper'

describe "Generate Thumbnail" do
  before(:all) do
    @video_id = test_video_id("user1")
    @video_id2 = test_video_id("user2")
  end

  context "when user is unauthenticated" do
    it_behaves_like "Unauthenticated", ->(api) do
      api.generate_thumbnail(test_video_id("user1"), time: 3)
    end
  end

  context "Authenticated User" do
    context "RW token" do
      before(:all) do
        @api = _api(login: user1["login"],
                    application_token: user1["rw_token"])
      end

      context "when params are valid" do
        before(:all) do
          @res = @api.generate_thumbnail(test_video_id("user1"), time: 3)
        end

        it_behaves_like "202 Accepted"
      end

      context "when time param is invalid" do
        before(:all) do
          @res = @api.generate_thumbnail(test_video_id("user1"), time: "invalid")
        end

        it_behaves_like "422 Failure"

        specify do
          expect(@res.errors.first["thumb_time"]).to eq("invalid integer")
        end
      end
    end


    context "RO token" do
      it_behaves_like "RO only", user1["login"], user1["ro_token"], ->(api) do
        api.generate_thumbnail(test_video_id("user1"), time: 3)
      end
    end


    context "when user doesn't have permission to the video" do
      before(:all) do
        api = _api(login: user1["login"],
                   application_token: user1["rw_token"])
        @res = api.generate_thumbnail(test_video_id("user2"), time: 3)
      end

      it_behaves_like "422 Failure"

      specify do
        expect(@res.errors.first["user"]).to match(/Permission Denied/)
      end
    end
  end
end
