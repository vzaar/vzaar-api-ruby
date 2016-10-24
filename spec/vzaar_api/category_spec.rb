module VzaarApi
  describe Category do

    before do
      setup_auth!
    end

    describe '.find' do
      context 'when the category can be found' do
        it 'finds the category' do
          VCR.use_cassette('categories/find') do
            res = described_class.find(331)
            expect(res['id']).to eq 331
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

  end
end
