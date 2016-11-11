module VzaarApi
  describe Category do

    before do
      setup_auth!
    end

    describe '.find' do
      context 'when the category can be found' do
        it 'finds the category' do
          VCR.use_cassette('categories/find') do
            category = described_class.find(334)
            expect(category.id).to eq 334
            expect(category.account_id).to eq 79357
            expect(category.user_id).to eq 79357
            expect(category.name).to eq 'Indoors'
            expect(category.description).to eq 'All indoor videos'
            expect(category.parent_id).to eq 331
            expect(category.depth).to eq 1
            expect(category.node_children_count).to eq 2
            expect(category.tree_children_count).to eq 2
            expect(category.node_video_count).to eq 2
            expect(category.tree_video_count).to eq 3
            expect(category.created_at).to eq '2015-04-07T09:39:06.000Z'
            expect(category.updated_at).to eq '2016-10-18T16:29:11.000Z'
          end
        end
      end

      context 'when the category cannot be found' do
        it 'raises an error' do
          VCR.use_cassette('categories/find_404') do
            expect { described_class.find(-1) }.
              to raise_error(Error, 'Not found: Resource cannot be found')
          end
        end
      end
    end

    describe '.each' do
      it 'loads the category collection' do
        VCR.use_cassette('categories/each') do
          enum = described_class.each(per_page: 2)
          ids = enum.map { |category| category.id }
          expect(ids).to match_array [331, 332, 333, 334, 335, 336, 2232, 2233, 2234, 2235, 2236, 2237]
        end
      end
    end

    describe '.paginate' do
      it 'loads the category collection' do
        VCR.use_cassette('categories/paginate_first') do
          pager = described_class.paginate(per_page: 3)
          pager.load!
          ids = pager.collection.map { |category| category.id }
          expect(ids).to match_array [331, 332, 333]
        end
      end

      it 'loads the category collection' do
        VCR.use_cassette('categories/paginate_next') do
          pager = described_class.paginate(per_page: 3)
          pager.load!
          pager.next
          ids = pager.collection.map { |category| category.id }
          expect(ids).to match_array [334, 335, 336]
        end
      end

      it 'loads the category collection' do
        VCR.use_cassette('categories/paginate_last') do
          pager = described_class.paginate(per_page: 3)
          pager.load!
          pager.last
          ids = pager.collection.map { |category| category.id }
          expect(ids).to match_array [2235, 2236, 2237]
        end
      end

      it 'loads the category collection' do
        VCR.use_cassette('categories/paginate_previous') do
          pager = described_class.paginate(page: 4, per_page: 3)
          pager.load!
          pager.previous
          ids = pager.collection.map { |category| category.id }
          expect(ids).to match_array [2232, 2233, 2234]
        end
      end
    end

    describe '#subtree' do
      it 'loads the category subtree' do
        VCR.use_cassette('categories/subtree') do
          category = described_class.find(331)
          pager = category.subtree
          pager.load!
          ids = pager.collection.map { |category| category.id }
          expect(ids).to match_array [331, 333, 334, 2233, 2234, 2235]
        end
      end

      it 'loads the category subtree' do
        VCR.use_cassette('categories/subtree_paginate_first') do
          category = described_class.find(331)
          pager = category.subtree(per_page: 2)
          pager.load!
          ids = pager.collection.map { |category| category.id }
          expect(ids).to match_array [331, 333]
        end
      end

      it 'loads the category subtree' do
        VCR.use_cassette('categories/subtree_paginate_next') do
          category = described_class.find(331)
          pager = category.subtree(per_page: 2)
          pager.load!
          pager.next
          ids = pager.collection.map { |category| category.id }
          expect(ids).to match_array [334, 2233]
        end
      end

      it 'loads the category subtree' do
        VCR.use_cassette('categories/subtree_paginate_previous') do
          category = described_class.find(331)
          pager = category.subtree(per_page: 2, page: 2)
          pager.load!
          pager.previous
          ids = pager.collection.map { |category| category.id }
          expect(ids).to match_array [331, 333]
        end
      end

      it 'loads the category subtree' do
        VCR.use_cassette('categories/subtree_paginate_last') do
          category = described_class.find(331)
          pager = category.subtree(per_page: 2, page: 2)
          pager.load!
          pager.last
          ids = pager.collection.map { |category| category.id }
          expect(ids).to match_array [2234, 2235]
        end
      end
    end

  end
end
