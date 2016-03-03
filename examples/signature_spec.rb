require_relative './spec_helper'

describe "Signature" do
  describe "signature" do
    context "when user is unauthenticated" do
      it_behaves_like "Unauthenticated", ->(api) do
        api.signature(path: './spec/support/video.mov')
      end
    end

    context "with no :sucess_action_redirect" do
      it "should be successful" do
        api = _api(login: user1["login"], application_token: user1["rw_token"])
        signature = api.signature(path: './spec/support/video.mov')
        expect(signature.http_status_code).to eq 200
      end
    end

    context "with unencoded :success_action_redirect" do
      it "should be successful" do
        api = _api(login: user1["login"], application_token: user1["rw_token"])
        signature = api.signature(path: './spec/support/video.mov',
          success_action_redirect: 'http://test.com')
        expect(signature.http_status_code).to eq 200
      end
    end

    context "with URI encoded :success_action_redirect" do
      it "should be successful" do
        api = _api(login: user1["login"], application_token: user1["rw_token"])
        signature = api.signature(path: './spec/support/video.mov',
          success_action_redirect: CGI.escape("http://test.com"))
        expect(signature.http_status_code).to eq 200
      end
    end

    context "encoded :success_action_redirect with qs parameters" do
      it "should be successful" do
        api = _api(login: user1["login"], application_token: user1["rw_token"])
        signature = api.signature(path: './spec/support/video.mov',
          success_action_redirect: CGI.escape("http://test.com?x=y"))
        expect(signature.http_status_code).to eq 200
      end
    end

    context "with a :success_action_redirect with qs parameters" do
      it "should be successful" do
        api = _api(login: user1["login"], application_token: user1["rw_token"])
        signature = api.signature(path: './spec/support/video.mov',
          success_action_redirect: "http://test.com?x")
        expect(signature.http_status_code).to eq 200
      end
    end
  end
end
