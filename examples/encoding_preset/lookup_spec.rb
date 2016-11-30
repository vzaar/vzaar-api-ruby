require_relative './../spec_helper'

module VzaarApi
  describe 'Encoding preset: Lookup' do

    let(:described_class) { EncodingPreset }
    let(:id) { api_envs['encoding_preset_id'] }

    context 'when user is authenticated' do
      before { setup_for :account_owner }

      context 'and resource can be found' do
        subject { described_class.find(id) }
        specify { expect(subject.id).to eq id }
      end

      context 'and resource cannot be found' do
        it 'raises an error' do
          expect{ described_class.find(-1) }.to raise_error(
            Error, 'Not found: Resource cannot be found')
        end
      end
    end

    context 'when user is not authenticated' do
      before { setup_for :intruder }

      it 'raises an error' do
        expect{ described_class.find(id) }.to raise_error(
          Error, 'Authentication failed: Invalid credentials')
      end
    end

  end
end
