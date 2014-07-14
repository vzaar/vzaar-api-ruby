require_relative './spec_helper'

describe "Add Subtitle" do
  context "when user is unauthenticated" do
    it_behaves_like "Unauthenticated", -> (api) do
      api.add_subtitle(test_video_id("user1"), body: "x", language: "en")
    end
  end

  context "Authenticated User" do
    before(:all) do
      @api = _api(login: user1["login"],
                  application_token: user1["rw_token"])
    end

    context "RW token" do
      context "when params are valid" do
        before(:all) do
          @res = @api.add_subtitle(test_video_id("user1"), body: "SRT", language: "en")
        end

        it_behaves_like "202 Accepted"
      end

      context "when language param is blank" do
        before(:all) do
          @res = @api.add_subtitle(test_video_id("user1"), body: "SRT", language: "")
        end

        it_behaves_like "422 Failure"

        specify { expect(@res.errors.first["language"]).to eq("empty string") }
      end
    end


    context "RO token" do
      it_behaves_like "RO only", user1["login"], user1["ro_token"], -> (api) do
        api.add_subtitle(test_video_id("user1"), body: "SRT", language: "en")
      end
    end

    context "when user doesn't have permission to the video" do
      before(:all) do
        @res = @api.add_subtitle(test_video_id("user2"), body: "SRT", language: "en")
      end

      it_behaves_like "422 Failure"

      specify do
        expect(@res.errors.first["user"]).to match(/Permission Denied/)
      end
    end
  end
end
