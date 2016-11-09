module VzaarApi
  describe Rendition do

    before do
      setup_auth!
    end

    describe '#initialize' do
      subject { described_class.new attrs }

      let(:attrs) do
        {
          id: 'id',
          encoding_preset_id: 'encoding_preset_id',
          state: 'state',
          source_as_rendition: 'source_as_rendition',
          name: 'name',
          output_format: 'output_format',
          bitrate_kbps: 'bitrate_kbps',
          width: 'width',
          height: 'height',
          video_codec: 'video_codec',
          profile: 'profile',
          frame_rate: 'frame_rate',
          keyframe: 'keyframe',
          audio_bitrate_kbps: 'audio_bitrate_kbps',
          audio_channels: 'audio_channels',
          audio_sample_rate: 'audio_sample_rate',
          size_in_bytes: 'size_in_bytes',
          error_message: 'error_message',
          created_at: 'created_at',
          updated_at: 'updated_at'
        }
      end

      specify { expect(subject.id).to eq 'id' }
      specify { expect(subject.encoding_preset_id).to eq 'encoding_preset_id' }
      specify { expect(subject.state).to eq 'state' }
      specify { expect(subject.source_as_rendition).to eq 'source_as_rendition' }
      specify { expect(subject.name).to eq 'name' }
      specify { expect(subject.output_format).to eq 'output_format' }
      specify { expect(subject.bitrate_kbps).to eq 'bitrate_kbps' }
      specify { expect(subject.width).to eq 'width' }
      specify { expect(subject.height).to eq 'height' }
      specify { expect(subject.video_codec).to eq 'video_codec' }
      specify { expect(subject.profile).to eq 'profile' }
      specify { expect(subject.frame_rate).to eq 'frame_rate' }
      specify { expect(subject.keyframe).to eq 'keyframe' }
      specify { expect(subject.audio_bitrate_kbps).to eq 'audio_bitrate_kbps' }
      specify { expect(subject.audio_channels).to eq 'audio_channels' }
      specify { expect(subject.audio_sample_rate).to eq 'audio_sample_rate' }
      specify { expect(subject.size_in_bytes).to eq 'size_in_bytes' }
      specify { expect(subject.error_message).to eq 'error_message' }
      specify { expect(subject.created_at).to eq 'created_at' }
      specify { expect(subject.updated_at).to eq 'updated_at' }
    end

  end
end
