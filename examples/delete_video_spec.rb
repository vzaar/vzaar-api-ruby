require_relative './spec_helper'

describe "Delete Video" do
  vid_id = nil
  file_path = "./spec/support/video.mov"
  desc = "Delete Video"

  describe "POST verb" do
    before(:all) do
      @api = _api(login: user1["login"],
                  application_token: user1["rw_token"])

      title = "api-test-#{rand_str}"
      res = @api.upload_video(path: file_path, title: title, description: desc)
      @vid_id = res.id
    end

    context "when there is no method=delete param" do
      describe "xml" do
        specify do
          opts = { video_id: @vid_id, http_verb: :post}
          req = Vzaar::Request::DeleteVideo.new(@api.conn, opts)

          expect { req.execute }.to raise_error(Vzaar::Error)
        end
      end

      describe "json" do
        specify do
          opts = { video_id: @vid_id, http_verb: :post, format: :json}
          req = Vzaar::Request::DeleteVideo.new(@api.conn, opts)

          expect { req.execute }.to raise_error(Vzaar::Error)
        end
      end
    end

    context "when method=delete exists in post body" do
      describe "xml" do
        specify do
          opts = { video_id: @vid_id, http_verb: :post}
          req = Vzaar::Request::DeleteVideo.new(@api.conn, opts)

          def req.xml_body
            '<?xml version="1.0" encoding="UTF-8"?><vzaar-api><_method>delete</_method></vzaar-api>'
          end
          res = req.execute
          expect(res.http_status_code).to eq(200)
        end
      end

      describe "json" do
        specify do
          title = "api-test-#{rand_str}"
          res = @api.upload_video(path: file_path, title: title, description: desc)
          vid_id = res.id


          opts = { video_id: vid_id, http_verb: :post, format: :json}
          req = Vzaar::Request::DeleteVideo.new(@api.conn, opts)

          def req.json_body
            { "vzaar-api" => { "_method" => "delete" } }
          end

          res = req.execute
          expect(res["title"]).to eq(title)
        end
      end
    end

  end

  describe "DELETE verb" do
    before(:all) do
      @api = _api(login: user1["login"],
                  application_token: user1["rw_token"])

      @title = "api-test-#{rand_str}"

      res = @api.upload_video(path: file_path, title: @title, description: desc)
      vid_id = res.id
    end

    context "when user is unauthenticated" do
      it_behaves_like "Unauthenticated", ->(api) do
        api.delete_video(vid_id)
      end
    end

    context "Authenticated User" do
      context "different account" do
        specify do
          api = _api(login: user2["login"],
                     application_token: user2["rw_token"])
          expect do
            api.delete_video(vid_id)
          end.to raise_error(Vzaar::Error, "Protected Resource")
        end
      end

      context "RW token" do
        before(:all) do
          @res = @api.delete_video(vid_id)
        end

        specify { expect(@res.http_status_code).to eq 200 }
        specify { expect(@res.title).to eq(@title) }
      end

      context "RO token" do
        it_behaves_like "RO only", user1["login"], user1["ro_token"], ->(api) do
          api.delete_video(vid_id)
        end
      end
    end
  end
end
