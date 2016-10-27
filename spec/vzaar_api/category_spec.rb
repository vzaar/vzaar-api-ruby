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

    describe '.find_each' do
      it 'loads the category collection' do
        VCR.use_cassette('categories/find_each') do
          enum = described_class.find_each(per_page: 2)
          ids = enum.map { |category| category.id }
          expect(ids).to match_array [331, 332, 333, 334, 335, 336, 2232, 2233, 2234, 2235, 2236, 2237]
        end
      end
    end

    describe '.all' do
      it 'loads the category collection' do
        VCR.use_cassette('categories/all_page_1') do
          arr = described_class.all(per_page: 2)
          ids = arr.map { |category| category.id }
          expect(ids).to match_array [331, 332]
        end
      end

      it 'loads the category collection' do
        VCR.use_cassette('categories/all_page_2') do
          arr = described_class.all(page: 2, per_page: 2)
          ids = arr.map { |category| category.id }
          expect(ids).to match_array [333, 334]
        end
      end

      it 'loads the category collection' do
        VCR.use_cassette('categories/all_page_3') do
          arr = described_class.all(page: 3, per_page: 3)
          ids = arr.map { |category| category.id }
          expect(ids).to match_array [2232, 2233, 2234]
        end
      end
    end

  end
end
