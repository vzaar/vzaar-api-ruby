module VzaarApi
  module Lib
    describe Api do

      before do
        VzaarApi.auth_token = auth_token
        VzaarApi.client_id = client_id
        VzaarApi.hostname = hostname
      end

      let(:auth_token) { 'auth-token' }
      let(:client_id) { 'client-id' }
      let(:hostname) { 'app.vzaar.localhost' }

      describe '#headers' do
        let(:expected_result) do
          {
            'X-Auth-Token' => auth_token,
            'X-Client-Id'  => client_id,
            'Content-Type' => 'application/json'
          }
        end
        specify { expect(subject.headers).to eq expected_result }
      end

    end
  end
end
