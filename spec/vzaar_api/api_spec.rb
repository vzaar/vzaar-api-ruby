module VzaarApi
  describe Api do

    subject { described_class.new args }

    let(:args) do
      { auth_token: auth_token, client_id: client_id, hostname: hostname }
    end

    let(:auth_token) { 'auth-token' }
    let(:client_id) { 'client-id' }
    let(:hostname) { 'app.vzaar.localhost' }

    specify { expect(subject.auth_token).to eq auth_token }
    specify { expect(subject.client_id).to eq client_id }
    specify { expect(subject.hostname).to eq hostname }

  end
end
