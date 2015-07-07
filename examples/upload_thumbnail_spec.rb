require_relative './spec_helper'

describe "Upload Thumbnail" do
  file_path = "./spec/support/pic.jpg"

  context "when user is unauthenticated" do
    it_behaves_like "Unauthenticated", ->(api) do
      api.upload_thumbnail(test_video_id("user1"), path: file_path)
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
          @res = @api.upload_thumbnail(test_video_id("user1"), path: file_path)
        end

        it_behaves_like "202 Accepted"
      end
    end

    context "RO token" do
      it_behaves_like "RO only", user1["login"], user1["ro_token"], ->(api) do
        api.upload_thumbnail(test_video_id("user1"), path: file_path)
      end
    end

    context "when user doesn't have permission to the video" do
      before(:all) do
        api = _api(login: user1["login"],
                    application_token: user1["rw_token"])
        @res = api.upload_thumbnail(test_video_id("user2"), path: file_path)
      end

      it_behaves_like "422 Failure"

      specify do
        expect(@res.errors.first["user"]).to match(/Permission Denied/)
      end
    end
  end
end
