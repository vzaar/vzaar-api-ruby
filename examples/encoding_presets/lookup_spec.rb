require_relative './../spec_helper'

module VzaarApi
  describe 'Encoding presets: Lookup' do

    let(:described_class) { EncodingPreset }

    context 'when user is authenticated' do
      before { setup_for :account_owner }

      context 'and resource can be found' do
        subject { described_class.find(3) }
        specify { expect(subject.id).to eq 3 }
      end

      context 'and resource cannot be found' do
        it 'raises an error' do
          expect{ described_class.find(-1) }.to raise_error(
            Error, 'Not found: Resource cannot be found')
        end
      end
    end

    context 'when user is no authenticated' do
      before { setup_for :intruder }

      it 'raises an error' do
        expect{ described_class.find(3) }.to raise_error(
          Error, 'Authentication failed: Invalid credentials')
      end
    end

  end
end
