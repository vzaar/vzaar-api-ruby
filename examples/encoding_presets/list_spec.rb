require_relative './../spec_helper'

describe 'Encoding presets: List' do
  context 'when user is authenticated' do
    before { setup_for :account_owner }

    it 'retrieves the resource list' do
      pager = VzaarApi::EncodingPreset.paginate(per_page: 3)
      expect(pager.first.count).to eq 3
    end
  end

  context 'when user is no authenticated' do
    before { setup_for :intruder }

    it 'raises an error' do
      pager = VzaarApi::EncodingPreset.paginate
      expect{ pager.first }.to raise_error(
        VzaarApi::Error, 'Authentication failed: Invalid credentials')
    end
  end
end
