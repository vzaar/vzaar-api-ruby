module VzaarApi
  describe Video do

    before do
      setup_auth!
    end

    describe '#initialize' do
      subject { described_class.new attrs }

      let(:attrs) do
        {
          id: 'id',
          title: 'title',
          user_id: 'user_id',
          account_id: 'account_id',
          description: 'description',
          private: 'private',
          seo_url: 'seo_url',
          url: 'url',
          thumbnail_url: 'thumbnail_url',
          state: 'state',
          duration: 'duration',
          categories: categories,
          renditions: renditions,
          created_at: 'created_at',
          updated_at: 'updated_at',
        }
      end

      let(:categories) do
        [ { id: 'category-id' } ]
      end

      let(:renditions) do
        [ { id: 'rendition-id' } ]
      end

      specify { expect(subject.id).to eq 'id' }
      specify { expect(subject.title).to eq 'title' }
      specify { expect(subject.user_id).to eq 'user_id' }
      specify { expect(subject.account_id).to eq 'account_id' }
      specify { expect(subject.description).to eq 'description' }
      specify { expect(subject.private).to eq 'private' }
      specify { expect(subject.seo_url).to eq 'seo_url' }
      specify { expect(subject.url).to eq 'url' }
      specify { expect(subject.thumbnail_url).to eq 'thumbnail_url' }
      specify { expect(subject.state).to eq 'state' }
      specify { expect(subject.duration).to eq 'duration' }
      specify { expect(subject.categories.first.id).to eq 'category-id' }
      specify { expect(subject.renditions.first.id).to eq 'rendition-id' }
      specify { expect(subject.created_at).to eq 'created_at' }
      specify { expect(subject.updated_at).to eq 'updated_at' }
    end

    describe 'description' do
      let(:video) do
        VCR.use_cassette('videos/find') do
          described_class.find(11060746)
        end
      end

      context 'when nothing has changed' do
        let(:changed) { [] }
        let(:changed_attributes) { {} }
        let(:changes) { {} }

        specify { expect(video).not_to be_changed }
        specify { expect(video.changed).to match_array changed }
        specify { expect(video.changed_attributes).to eq changed_attributes }
        specify { expect(video.changes).to eq changes }
      end

      context 'when attributes have changed' do
        before do
          video.title = 'new-title'
          video.description = 'new-desc'
        end

        let(:changed) { [:title, :description] }
        let(:changed_attributes) { { title: 'new-title', description: 'new-desc'} }
        let(:changes) { { title: ["LS TEST VIDEO", "new-title"], description: ["", "new-desc"]} }

        specify { expect(video).to be_changed }
        specify { expect(video.changed).to match_array changed }
        specify { expect(video.changed_attributes).to eq changed_attributes }
        specify { expect(video.changes).to eq changes }
      end
    end

    describe '.find' do
      context 'when the video can be found' do
        it 'finds the video' do
          VCR.use_cassette('videos/find_alt') do
            video = described_class.find(11060741)
            expect(video.id).to eq 11060741
            expect(video.title).to eq 'LS TEST VIDEO'
            expect(video.user_id).to eq 139477
            expect(video.account_id).to eq 1970313
            expect(video.description).to eq ''
            expect(video.private).to eq false
            expect(video.seo_url).to eq nil
            expect(video.url).to eq 'https://raazv.com/videos/11060741'
            expect(video.thumbnail_url).to eq 'https://view.raazv.com/11060741/thumb'
            expect(video.state).to eq 'ready'
            expect(video.duration).to eq 634.6
            expect(video.categories.count).to eq 0
            expect(video.renditions.count).to eq 4
            expect(video.legacy_renditions.count).to eq 4
            expect(video.created_at).to eq '2021-05-21T11:37:35.000Z'
            expect(video.updated_at).to eq '2021-05-21T12:29:46.000Z'
          end
        end
      end

      context 'when the video cannot be found' do
        it 'raises an error' do
          VCR.use_cassette('videos/find_404') do
            expect { described_class.find(-1) }.
              to raise_error(Error, 'Not found: Resource cannot be found')
          end
        end
      end
    end

    describe '.create' do
      context 'when we already have the guid' do
        let(:attrs) do
          { guid: 'tkHzDBRpgWp8' }
        end

        # TODO: Make some test GUIDS for final run
        # context 'and a new video is created' do
        #   it 'returns the new video' do
        #     VCR.use_cassette('videos/create/guid_201') do
        #       video = described_class.create(attrs)
        #       expect(video.id).to eq 11060741, 11060742, 11060743
        #     end
        #   end
        # end

        context 'and the video has already been created' do
          it 'raises an error' do
            VCR.use_cassette('videos/create/guid_error') do
              expect { described_class.create attrs }.to raise_error(
                Error, 'Invalid parameters: The provided guid already exists')
            end
          end
        end
      end

      context 'when we have a file path' do
        let(:attrs) do
          { path: 'spec/support/files/video-1.0MB.mp4', title: 'video' }
        end

        context 'and a new video is created' do
          it 'returns the new video' do
            VCR.use_cassette('videos/create/path_201') do
              video = described_class.create(attrs)
              expect(video.id.between?(10000000, 20000000)).to eq true
            end
          end
        end
      end

      context 'when we provide a url' do
        let(:attrs) do
          { url: 'http://example.com/video.mp4', uploader: UPLOADER }
        end

        context 'and a new video is created' do
          it 'returns the new video' do
            VCR.use_cassette('videos/create/link_201') do
              video = described_class.create(attrs)
              expect(video.id.between?(10000000, 20000000)).to eq true
            end
          end
        end

        context 'and invalid params are provided' do
          it 'raises an error' do
            VCR.use_cassette('videos/create/link_error') do
              attrs.delete :url
              expect { described_class.create attrs }.to raise_error(
                Error, 'Invalid parameters: Expected one of :guid, :path, :url')
            end
          end
        end
      end

      context 'when invalid params are provided' do
        it 'raises an error' do
          expect { described_class.create }.to raise_error(
            Error, 'Invalid parameters: Expected one of :guid, :path, :url')
        end
      end
    end

    # TODO: Provide working test video for final run
    # describe '#delete' do
    #   context 'when video is deleted successfully' do
    #     it 'returns true' do
    #       VCR.use_cassette('videos/delete_204') do
    #         video = described_class.find(7574985)
    #         expect(video.delete).to eq true
    #         expect { described_class.find(7574985) }.
    #           to raise_error(Error, 'Not found: Resource cannot be found')
    #       end
    #     end
    #   end
    # end

    describe '.paginate' do
      it 'loads the video collection' do
        VCR.use_cassette('videos/paginate_first') do
          pager = described_class.paginate(per_page: 3)
          pager.first
          ids = pager.collection.map { |video| video.id }
          expect(ids).to match_array [11060747, 11060748, 11060749]
        end
      end

      it 'loads the video collection' do
        VCR.use_cassette('videos/paginate_next') do
          pager = described_class.paginate(per_page: 3)
          pager.next
          ids = pager.collection.map { |video| video.id }
          expect(ids).to match_array [11060744, 11060745, 11060746]
        end
      end

      it 'loads the video collection' do
        VCR.use_cassette('videos/paginate_last') do
          pager = described_class.paginate(per_page: 3)
          pager.last
          ids = pager.collection.map { |video| video.id }
          expect(ids).to match_array [11060741, 11060742, 11060743]
        end
      end

      it 'loads the video collection' do
        VCR.use_cassette('videos/paginate_previous') do
          pager = described_class.paginate(page: 4, per_page: 3)
          pager.previous
          ids = pager.collection.map { |video| video.id }
          expect(ids).to match_array [11060741, 11060742, 11060743]
        end
      end
    end

    describe ".set_image_frame" do
      let(:video_id) { 11060746 }

      context "when params are valid" do
        it 'returns the existing video' do
          VCR.use_cassette('videos/image_frame_202') do
            video = described_class.set_image_frame(video_id, time: 3)
            expect(video.id).to eq video_id
          end
        end
      end

      context 'when invalid params are provided' do
        it 'raises an error' do
          VCR.use_cassette('videos/image_frame_422') do
            expect { described_class.set_image_frame(video_id, {}) }
              .to raise_error(Error, 'Invalid parameters: time is missing')
          end
        end
      end
    end

    describe ".upload_image_frame" do
      let(:video_id) { 11060746 }
      let(:path) { 'spec/support/files/drex.jpg' }

      context "when params are valid" do
        it 'returns the existing video' do
          VCR.configure do |c|
            c.cassette_library_dir = 'videos/image_upload_frame_202'
            c.preserve_exact_body_bytes do |http_message|
              video = described_class.upload_image_frame(video_id, path: path)
              expect(video.id).to eq video_id
            end
          end
        end
      end

      context 'when path param is missing' do
        it 'raises an error' do
          expect { described_class.upload_image_frame(video_id, {}) }
            .to raise_error(Error, 'Invalid parameters: path is missing')
        end
      end

      context 'when file is too big' do
        let(:path) { 'spec/support/files/video-12.0MB.mp4' }

        it 'raises an error' do
          VCR.configure do |c|
            c.cassette_library_dir = 'videos/image_upload_frame_422'
            c.preserve_exact_body_bytes do |http_message|
              expect { described_class.upload_image_frame(video_id, path: path) }
                .to raise_error(Error, 'File size exceeded: Max 10MB allowed')
            end
          end
        end
      end
    end
  end
end
