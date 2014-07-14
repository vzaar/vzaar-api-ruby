require_relative './spec_helper'

describe "Delete Video" do
  vid_id = nil

  before(:all) do
    file_path = "./spec/support/video.mov"
    desc = "Delete Video"
    @api = _api(login: user1["login"],
               application_token: user1["rw_token"])

    @title = "api-test-#{rand_str}"

    res = @api.upload_video(path: file_path, title: @title, description: desc)
    vid_id = res.id
  end

  context "when user is unauthenticated" do
    it_behaves_like "Unauthenticated", -> (api) do
      api.delete_video(vid_id)
    end
  end

  context "Authenticated User" do
    context "RW token" do
      before(:all) do
        @res = @api.delete_video(vid_id)
      end

      specify { expect(@res.http_status_code).to eq 200 }
      specify { expect(@res.title).to eq(@title) }
    end

    context "RO token" do
      it_behaves_like "RO only", user1["login"], user1["ro_token"], -> (api) do
        api.delete_video(vid_id)
      end
    end
  end
end
