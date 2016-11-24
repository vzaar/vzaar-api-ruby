module VzaarApi
  describe EncodingPreset do

    before do
      setup_auth!
    end

    describe '#to_hash' do
      it 'represents the instance as a hash' do
        VCR.use_cassette('encoding_presets/find') do
          preset = described_class.find(4).to_hash
          expect(preset[:id]).to eq 4
          expect(preset[:name]).to eq "SD"
          expect(preset[:description]).to eq "540p"
          expect(preset[:output_format]).to eq "mp4"
          expect(preset[:bitrate_kbps]).to eq 1944
          expect(preset[:long_dimension]).to eq 960
          expect(preset[:video_codec]).to eq "libx264"
          expect(preset[:profile]).to eq "main"
          expect(preset[:frame_rate]).to eq "29.97"
          expect(preset[:keyframe]).to eq 60
          expect(preset[:audio_bitrate_kbps]).to eq 128
          expect(preset[:audio_channels]).to eq 2
          expect(preset[:audio_sample_rate]).to eq 44100
          expect(preset[:max_bitrate_kbps]).to eq nil
          expect(preset[:keyframe_period]).to eq nil
          expect(preset[:created_at]).to eq "2016-11-09T11:01:38.000Z"
          expect(preset[:updated_at]).to eq "2016-11-09T11:01:38.000Z"
        end
      end
    end

    describe '.find' do
      context 'when the encoding preset can be found' do
        it 'finds the encoding preset' do
          VCR.use_cassette('encoding_presets/find') do
            preset = described_class.find(4)
            expect(preset.id).to eq 4
            expect(preset.name).to eq "SD"
            expect(preset.description).to eq "540p"
            expect(preset.output_format).to eq "mp4"
            expect(preset.bitrate_kbps).to eq 1944
            expect(preset.long_dimension).to eq 960
            expect(preset.video_codec).to eq "libx264"
            expect(preset.profile).to eq "main"
            expect(preset.frame_rate).to eq "29.97"
            expect(preset.keyframe).to eq 60
            expect(preset.audio_bitrate_kbps).to eq 128
            expect(preset.audio_channels).to eq 2
            expect(preset.audio_sample_rate).to eq 44100
            expect(preset.max_bitrate_kbps).to eq nil
            expect(preset.keyframe_period).to eq nil
            expect(preset.created_at).to eq "2016-11-09T11:01:38.000Z"
            expect(preset.updated_at).to eq "2016-11-09T11:01:38.000Z"
          end
        end
      end

      context 'when the encoding preset cannot be found' do
        it 'raises an error' do
          VCR.use_cassette('encoding_presets/find_404') do
            expect { described_class.find(-1) }.
              to raise_error(Error, 'Not found: Resource cannot be found')
          end
        end
      end
    end

    describe '.each_item' do
      it 'loads the category collection' do
        VCR.use_cassette('encoding_presets/each_item') do
          enum = described_class.each_item(per_page: 2)
          ids = enum.map { |preset| preset.id }
          expect(ids).to match_array [1, 2, 3, 4, 5, 6, 7, 8, 9]
        end
      end
    end

    describe '.paginate' do
      it 'loads the preset collection' do
        VCR.use_cassette('encoding_presets/paginate_first') do
          pager = described_class.paginate(per_page: 1)
          pager.first
          ids = pager.collection.map { |preset| preset.id }
          expect(ids).to match_array [4]
        end
      end

      it 'loads the preset collection' do
        VCR.use_cassette('encoding_presets/paginate_next') do
          pager = described_class.paginate(per_page: 1)
          pager.next
          ids = pager.collection.map { |preset| preset.id }
          expect(ids).to match_array [3]
        end
      end

      it 'loads the preset collection' do
        VCR.use_cassette('encoding_presets/paginate_last') do
          pager = described_class.paginate(per_page: 1)
          pager.last
          ids = pager.collection.map { |preset| preset.id }
          expect(ids).to match_array [1]
        end
      end

      it 'loads the preset collection' do
        VCR.use_cassette('encoding_presets/paginate_previous') do
          pager = described_class.paginate(page: 4, per_page: 1)
          pager.previous
          ids = pager.collection.map { |preset| preset.id }
          expect(ids).to match_array [2]
        end
      end
    end

  end
end
