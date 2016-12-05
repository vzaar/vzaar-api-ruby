require_relative './spec_helper'

module VzaarApi
  describe 'Rate limit' do

    let(:described_class) { EncodingPreset }
    let(:id) { api_envs['encoding_preset_id'] }

    before { setup_for :account_owner }

    it 'is available after each request' do
      EncodingPreset.find(id)
      expect(VzaarApi.rate_limit).to eq 200
      expect(VzaarApi.rate_limit_remaining).to be < 200
    end

  end
end
