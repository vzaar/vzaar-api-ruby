require_relative './spec_helper'

describe "Upload Audio" do

  context "File uploads" do
    file_path = "./spec/support/burial_short.wav"
    desc = "Upload audio"

    context "Authenticated User" do
      context "RW token" do
        before(:all) do
          api = _api(login: user1["login"],
                     application_token: user1["rw_token"])

          title = "api-test-#{rand_str}"
          @res = api.upload_audio(path: file_path, title: title, description: desc, bitrate: 192)
        end

        specify { expect(@res.http_status_code).to eq 201 }
        specify { expect(@res.id.to_s).to match(/^[0-9]+$/) }
      end

      context "RO token" do
        it_behaves_like "RO only", user1["login"], user1["ro_token"], ->(api) do
          api.upload_audio(path: file_path, description: desc, bitrate: 192)
        end
      end
    end

    context "when user is unauthenticated" do
      it_behaves_like "Unauthenticated", ->(api) do
        api.upload_audio(path: file_path, title: "woof", description: desc, bitrate: 192)
      end
    end
  end
end
