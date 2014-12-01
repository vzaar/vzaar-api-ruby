require_relative './spec_helper'

describe "Video List" do
  describe "authenticated" do
    describe "labels" do
      before do
        api = _api(login: user1["login"],
                   application_token: user1["rw_token"])
        
        @res = api.video_list(user1["login"], authenticated: true, params: { labels: "api,api2" })
      end

      specify { expect(@res.count).to eq(1) }
    end
  end
  
  describe "Unauthenticated" do
    context "when Public API Feeds is enabled" do
      describe "params" do
        before(:all) do
          @api = unauthenticated_api
        end

        describe "status" do
          context "when multiple values are passed" do
            before do
              @res = @api.video_list(user_with_public_api["login"], params: { status: "replaced,deleted" })
            end
            it_behaves_like "200 OK"
          end

          context "valid param" do
            before do
              @res = @api.video_list(user_with_public_api["login"], params: { status: "processing" })
            end
            it_behaves_like "200 OK"
          end

          context "when invalid param" do
            before do
              @res = @api.video_list(user_with_public_api["login"], params: { status: "boom" })
            end
            it_behaves_like "422 Failure"
          end
        end
      end
    end

    context "when Public API Feeds is disabled" do
      it_behaves_like "Unauthenticated", -> (api) do
        api.video_list(user1["login"])
      end
    end
  end
end
