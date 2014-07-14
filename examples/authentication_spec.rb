require_relative './spec_helper'

describe "Authentication" do
  describe "whoami" do
    context "when user is unauthenticated" do
      it_behaves_like "Unauthenticated", -> (api) { api.whoami }
    end

    context "when auth success" do
      specify do
        api = _api(login: user1["login"],
                   application_token: user1["rw_token"])

        expect(api.whoami).to eq(user1["login"])
      end
    end
  end
end
