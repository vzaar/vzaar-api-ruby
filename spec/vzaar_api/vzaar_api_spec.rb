describe VzaarApi do

  before do
    VzaarApi.auth_token = auth_token
    VzaarApi.client_id = client_id
    VzaarApi.hostname = hostname
  end

  let(:auth_token) { 'auth-token' }
  let(:client_id) { 'client-id' }
  let(:hostname) { 'app.vzaar.localhost' }

  specify { expect(VzaarApi.auth_token).to eq auth_token }
  specify { expect(VzaarApi.client_id).to eq client_id }
  specify { expect(VzaarApi.hostname).to eq hostname }

end
