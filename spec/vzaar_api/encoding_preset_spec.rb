module VzaarApi
  describe EncodingPreset do

    before do
      setup_auth!
    end

    describe 'a single instance' do
      it 'finds the encoding_preset' do
        VCR.use_cassette('encoding_presets/instance') do
          enum = described_class.each(per_page: 1)
          preset = enum.first
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

    describe '.each' do
      it 'loads the encoding-presets collection' do
        VCR.use_cassette('encoding_presets/each') do
          enum = described_class.each(per_page: 2)
          ids = enum.map { |preset| preset.id }
          expect(ids).to match_array [1, 2, 3, 4]
        end
      end
    end

    describe '.paginate' do
      it 'loads the preset collection' do
        VCR.use_cassette('encoding_presets/paginate_first') do
          pager = described_class.paginate(per_page: 1)
          pager.load!
          ids = pager.collection.map { |preset| preset.id }
          expect(ids).to match_array [4]
        end
      end

      it 'loads the preset collection' do
        VCR.use_cassette('encoding_presets/paginate_next') do
          pager = described_class.paginate(per_page: 1)
          pager.load!
          pager.next
          ids = pager.collection.map { |preset| preset.id }
          expect(ids).to match_array [3]
        end
      end

      it 'loads the preset collection' do
        VCR.use_cassette('encoding_presets/paginate_last') do
          pager = described_class.paginate(per_page: 1)
          pager.load!
          pager.last
          ids = pager.collection.map { |preset| preset.id }
          expect(ids).to match_array [1]
        end
      end

      it 'loads the preset collection' do
        VCR.use_cassette('encoding_presets/paginate_previous') do
          pager = described_class.paginate(page: 4, per_page: 1)
          pager.load!
          pager.previous
          ids = pager.collection.map { |preset| preset.id }
          expect(ids).to match_array [2]
        end
      end
    end

  end
end
