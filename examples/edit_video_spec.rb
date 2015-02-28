require_relative './spec_helper'

describe "Edit Video" do
  file_path = "./spec/support/video.mov"

  context "when user is unauthenticated" do
    it_behaves_like "Unauthenticated", -> (api) do
      api.edit_video(test_video_id("user1"), title: "foo")
    end
  end

  context "Authenticated User" do
    describe "POST verb" do
      before(:all) do
        @api = _api(login: user1["login"],
                    application_token: user1["rw_token"])
        @vid_id = test_video_id("user1")
      end

      before do
        opts = { video_id: @vid_id, http_verb: :post }
        @req = Vzaar::Request::EditVideo.new(@api.conn, opts)
      end

      context "when there is no method=put param" do
        describe "xml" do
          specify do
            res = @req.execute
            expect(res.status_code).to eq(404)
          end
        end
      end

      context "when method=put exists in post body" do
        describe "xml" do
          specify do

            def @req.xml_body
              <<-XML
                <?xml version="1.0" encoding="UTF-8"?>
                  <vzaar-api>
                    <_method>put</_method>
                    <video>
                      <title>woof</title>
                    </video>
                  </vzaar-api>
                XML
            end
            res = @req.execute
            expect(res.status_code).to eq(200)
          end
        end
      end
    end

    describe "PUT verb" do
      context "different account" do

        before do
          api = _api(login: user2["login"],
                     application_token: user2["rw_token"])
          @res =  api.edit_video(test_video_id("user1"), format: format)
        end

        describe "xml" do
          let(:format) { :xml }
          it_behaves_like("401 Unauthorized")
        end

        describe "json" do
          let(:format) { :json }
          it_behaves_like("401 Unauthorized")
        end
      end

      context "RW token" do
        before(:all) do
          @api = _api(login: user1["login"],
                      application_token: user1["rw_token"])
        end

        describe "updating params" do

          describe "xml" do
            before(:all) do
              @title = rand_str()
              @desc = rand_str()
              @res = @api.edit_video(test_video_id("user1"),
                                     title: @title,
                                     description: @desc)
            end

            it_behaves_like "200 OK"
            specify { expect(@res.resource.title).to eq(@title) }
            specify { expect(@res.resource.description).to eq(@desc) }
          end
        end

        describe "json" do
          before(:all) do
            @title = rand_str()
            @desc = rand_str()
            @res = @api.edit_video(test_video_id("user1"),
                                   title: @title,
                                   description: @desc,
                                   format: "json")
          end

          it_behaves_like "200 OK"
          specify { expect(@res.resource["oembed"]["title"]).to eq(@title) }
          specify { expect(@res.resource["oembed"]["description"]).to eq(@desc) }
        end
      end

      context "RO token" do
        it_behaves_like "RO only", user1["login"], user1["ro_token"], -> (api) do
          api.edit_video(test_video_id("user1"), title: "woof")
        end
      end
    end
  end
end
