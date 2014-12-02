require_relative './spec_helper'

describe "Upload Video" do

  context "File uploads" do
    file_path = "./spec/support/video.mov"
    desc = "Upload Video/File Uploads"

    context "Authenticated User" do
      context "RW token" do
        describe "xml" do
          before(:all) do
            api = _api(login: user1["login"],
                       application_token: user1["rw_token"])

            title = "api-test-#{rand_str}"
            @res = api.upload_video(path: file_path, title: title, description: desc)

            # cleanup
            api.delete_video(@res.id)
          end

          specify { expect(@res.http_status_code).to eq 201 }
          specify { expect(@res.id.to_s).to match(/^[0-9]+$/) }

          after(:all) do

          end
        end

        describe "json" do
          before(:all) do
            api = _api(login: user1["login"],
                       application_token: user1["rw_token"])

            title = "api-test-#{rand_str}"
            @res = api.upload_video(path: file_path, title: title, description: desc, format: :json)

            # cleanup
            api.delete_video(@res["id"])
          end

          specify { expect(@res["id"].to_s).to match(/^[0-9]+$/) }
        end
      end

      context "RO token" do
        it_behaves_like "RO only", user1["login"], user1["ro_token"], -> (api) do
          api.upload_video(path: file_path, description: desc)
        end
      end
    end

    context "when user is unauthenticated" do
      it_behaves_like "Unauthenticated", -> (api) do
        api.upload_video(path: file_path, title: "woof", description: desc)
      end
    end
  end



  context "Link uploads" do
    desc = "Upload Video/Link Uploads"
    file_url = "http://samples.mplayerhq.hu/MPEG-4/turn-on-off.mp4"

    context "Authenticated User" do
      before(:all) do
        api = _api(login: user1["login"],
                   application_token: user1["rw_token"])

        title = "api-test-#{rand_str}"
        @res = api.upload_video(url: file_url, title: title, description: desc)

        # cleanup
        api.delete_video(@res.id)
      end

      specify { expect(@res.http_status_code).to eq 200 }
      specify { expect(@res.id.to_s).to match(/^[0-9]+$/) }
    end

    context "when user is unauthenticated" do
      it_behaves_like "Unauthenticated", -> (api) do
        api.upload_video(url: file_url, title: "woof", description: desc)
      end
    end
  end
end
