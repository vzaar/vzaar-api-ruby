require_relative './../spec_helper'

module VzaarApi
  describe 'Category: List' do

    let(:described_class) { Category }

    context 'when user is authenticated' do
      before { setup_for :account_owner }

      describe '#each_item' do
        it 'retrieves the resource list' do
          ids = described_class.each_item.map(&:id)
          expect(ids).not_to be_empty
        end
      end

      describe '#paginate' do
        let(:pager) { described_class.paginate(page: 2, per_page: 1) }
        specify { expect(pager.first.count).to eq 1 }
        specify { expect(pager.next.count).to eq 1 }
        specify { expect(pager.previous.count).to eq 1 }
        specify { expect(pager.last.count).to eq 1 }
      end
    end

    context 'when user is not authenticated' do
      before { setup_for :intruder }

      it 'raises an error' do
        pager = described_class.paginate
        expect{ pager.first }.to raise_error(
          Error, 'Authentication failed: Invalid credentials')
      end
    end

  end
end
