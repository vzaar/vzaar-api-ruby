describe VzaarApi do

  before do
    VzaarApi.auth_token = auth_token
    VzaarApi.client_id = client_id
    VzaarApi.hostname = hostname
  end

  let(:auth_token) { 'xdyzFwz8DV5pq1MDGE7e' }
  let(:client_id) { 'capo-sixth-gale' }
  let(:hostname) { 'app.vzaar.com' }

  specify { expect(VzaarApi.auth_token).to eq auth_token }
  specify { expect(VzaarApi.client_id).to eq client_id }
  specify { expect(VzaarApi.hostname).to eq hostname }
  specify { expect(VzaarApi.protocol).to eq 'https' }

end
