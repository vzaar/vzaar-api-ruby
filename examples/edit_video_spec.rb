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

      context "when there is no method=put param" do
        describe "xml" do
          specify do
            opts = { video_id: @vid_id, http_verb: :post }
            req = Vzaar::Request::EditVideo.new(@api.conn, opts)

            expect { req.execute }.to raise_error(Vzaar::Error)
          end
        end
      end

      context "when method=put exists in post body" do
        describe "xml" do
          specify do
            opts = { video_id: @vid_id, http_verb: :post}
            req = Vzaar::Request::EditVideo.new(@api.conn, opts)

            def req.xml_body
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

            res = req.execute
            expect(res.http_status_code).to eq(200)
          end
        end
      end
    end

    describe "PUT verb" do
      context "different account" do

        describe "xml" do
          specify do
            api = _api(login: user2["login"],
                       application_token: user2["rw_token"])

            expect do
              api.edit_video(test_video_id("user1"))
            end.to raise_error(Vzaar::Error, "Protected Resource")
          end
        end

        describe "json" do
          specify do
            api = _api(login: user2["login"],
                       application_token: user2["rw_token"])

            expect do
              api.edit_video(test_video_id("user1"), format: "json")
            end.to raise_error(Vzaar::Error, "Protected Resource")
          end
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
            specify { expect(@res.title).to eq(@title) }
            specify { expect(@res.description).to eq(@desc) }
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

          specify { expect(@res["oembed"]["title"]).to eq(@title) }
          specify { expect(@res["oembed"]["description"]).to eq(@desc) }
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
