require_relative './../spec_helper'

module VzaarApi
  describe 'Category: List' do

    let(:described_class) { Category }

    let(:category) { described_class.find(id) }
    let(:id) { api_envs['category_id'] }

    context 'when user is authenticated' do
      before { setup_for :account_owner }

      describe '#each_item' do
        it 'retrieves the resource list' do
          ids = category.subtree.each_item.map(&:id)
          expect(ids).not_to be_empty
        end
      end

      describe '#paginate' do
        let(:pager) { category.subtree(page: 2, per_page: 1) }
        specify { expect(pager.first.count).to eq 1 }
        specify { expect(pager.next.count).to eq 1 }
        specify { expect(pager.previous.count).to eq 1 }
        specify { expect(pager.last.count).to eq 1 }
      end
    end

    context 'when user is not authenticated' do
      before { setup_for :intruder }

      it 'raises an error' do
        expect{ category.subtree }.to raise_error(
          Error, 'Authentication failed: Invalid credentials')
      end
    end

  end
end
