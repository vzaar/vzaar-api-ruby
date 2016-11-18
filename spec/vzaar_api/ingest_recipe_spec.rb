module VzaarApi
  describe IngestRecipe do

    before do
      setup_auth!
    end

    describe '.find' do
      context 'when the recipe can be found' do
        it 'finds the recipe' do
          VCR.use_cassette('ingest_reipces/find') do
            recipe = described_class.find(1)
            expect(recipe.id).to eq 1
            expect(recipe.name).to eq "new-video"
            expect(recipe.recipe_type).to eq "new_video"
            expect(recipe.description).to be_nil
            expect(recipe.account_id).to eq 79357
            expect(recipe.user_id).to eq 79357
            expect(recipe.default).to eq true
            expect(recipe.multipass).to eq false
            expect(recipe.frame_grab_time).to eq "3.5"
            expect(recipe.generate_animated_thumb).to eq true
            expect(recipe.generate_sprite).to eq true
            expect(recipe.use_watermark).to eq true
            expect(recipe.send_to_youtube).to eq false
            expect(recipe.encoding_presets.count).to eq 5
            expect(recipe.created_at).to eq '2016-11-09T11:01:38.000Z'
            expect(recipe.updated_at).to eq '2016-11-09T11:01:38.000Z'
          end
        end
      end

      context 'when the recipe cannot be found' do
        it 'raises an error' do
          VCR.use_cassette('ingest_reipces/find_404') do
            expect { described_class.find(-1) }.
              to raise_error(Error, 'Not found: Resource cannot be found')
          end
        end
      end
    end

    describe '.create' do
      context 'when recipe is created successfully' do
        let(:attrs) do
          {
            name: 'new-recipe',
            description: 'the new recipe',
            default: true,
            frame_grab_time: 5.5,
            multipass: false,
            generate_animated_thumb: true,
            generate_sprite: true,
            use_watermark: true,
            send_to_youtube: true,
            encoding_preset_ids: '1,2,3,4'
          }
        end

        it 'returns the ingest recipe object' do
          VCR.use_cassette('ingest_reipces/create_200') do
            recipe = described_class.create(attrs)
            expect(recipe.id).to eq 8
            expect(recipe.name).to eq "new-recipe"
            expect(recipe.recipe_type).to eq "new_video"
            expect(recipe.description).to eq 'the new recipe'
            expect(recipe.account_id).to eq 79357
            expect(recipe.user_id).to eq 79357
            expect(recipe.default).to eq true
            expect(recipe.multipass).to eq false
            expect(recipe.frame_grab_time).to eq '5.5'
            expect(recipe.generate_animated_thumb).to eq true
            expect(recipe.generate_sprite).to eq true
            expect(recipe.use_watermark).to eq true
            expect(recipe.send_to_youtube).to eq true
            expect(recipe.encoding_presets.count).to eq 4
            expect(recipe.created_at).to eq '2016-11-18T10:25:47.996Z'
            expect(recipe.updated_at).to eq '2016-11-18T10:25:47.996Z'
          end
        end
      end

      context 'when an error is returned' do
        let(:attrs) { { junk: 'yard' } }
        it 'raises the error returned form the API' do
          VCR.use_cassette('ingest_reipces/create_422') do
            expect { described_class.create(attrs) }.
              to raise_error(Error, 'Invalid parameters: name is missing, ' \
                'encoding_preset_ids is missing, encoding_preset_ids is invalid')
          end
        end
      end
    end

    describe '#save' do
      context 'when recipe is updated successfully' do
        it 'returns the ingest recipe object' do
          VCR.use_cassette('ingest_reipces/update_200') do
            presets = EncodingPreset.paginate(per_page: 3).load!.collection
            recipe = described_class.find(8)
            recipe.name = 'updated'
            recipe.encoding_presets = presets
            expect(recipe.save).to eq true
            expect(recipe.name).to eq 'updated'
            expect(recipe.encoding_presets.count).to eq 3
            expect(recipe.created_at).to eq '2016-11-18T10:25:47.000Z'
            expect(recipe.updated_at).to eq '2016-11-18T11:20:06.490Z'
          end
        end
      end

      context 'when an error is returned' do
        it 'raises the error returned form the API' do
          VCR.use_cassette('ingest_reipces/update_422') do
            recipe = described_class.find(8)
            recipe.encoding_presets = nil
            expect { recipe.save }.to raise_error(
              Error, 'Invalid parameters: encoding_preset_ids is invalid')
          end
        end
      end
    end

    describe '#delete' do
      context 'when recipe is deleted successfully' do
        it 'returns true' do
          VCR.use_cassette('ingest_reipces/delete_201') do
            recipe = described_class.find(7)
            expect(recipe.delete).to eq true
            expect { described_class.find(7) }.
              to raise_error(Error, 'Not found: Resource cannot be found')
          end
        end
      end

      context 'when an error is returned' do
        it 'raises the error returned form the API' do
          VCR.use_cassette('ingest_reipces/delete_422') do
            recipe = described_class.find(8)
            expect { recipe.delete }.to raise_error(
              Error, 'Invalid parameters: You cannot delete your default ingest recipe')
          end
        end
      end
    end

    describe '.each' do
      it 'loads the recipe collection' do
        VCR.use_cassette('ingest_reipces/each') do
          enum = described_class.each(per_page: 2)
          ids = enum.map { |recipe| recipe.id }
          expect(ids).to match_array [1, 2, 3, 5, 7]
        end
      end
    end

    describe '.paginate' do
      it 'loads the recipe collection' do
        VCR.use_cassette('ingest_reipces/paginate_first') do
          pager = described_class.paginate(per_page: 1)
          pager.load!
          ids = pager.collection.map { |recipe| recipe.id }
          expect(ids).to match_array [1]
        end
      end

      it 'loads the recipe collection' do
        VCR.use_cassette('ingest_reipces/paginate_next') do
          pager = described_class.paginate(per_page: 1)
          pager.load!
          pager.next
          ids = pager.collection.map { |recipe| recipe.id }
          expect(ids).to match_array [2]
        end
      end

      it 'loads the recipe collection' do
        VCR.use_cassette('ingest_reipces/paginate_last') do
          pager = described_class.paginate(per_page: 1)
          pager.load!
          pager.last
          ids = pager.collection.map { |recipe| recipe.id }
          expect(ids).to match_array [7]
        end
      end

      it 'loads the recipe collection' do
        VCR.use_cassette('ingest_reipces/paginate_previous') do
          pager = described_class.paginate(page: 4, per_page: 1)
          pager.load!
          pager.previous
          ids = pager.collection.map { |recipe| recipe.id }
          expect(ids).to match_array [3]
        end
      end
    end

  end
end
