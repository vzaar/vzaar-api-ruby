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
      specify { expect(subject.categories.first.id).to eq 'category-id' }
      specify { expect(subject.renditions.first.id).to eq 'rendition-id' }
      specify { expect(subject.created_at).to eq 'created_at' }
      specify { expect(subject.updated_at).to eq 'updated_at' }
    end

    describe 'description' do
      let(:video) do
        VCR.use_cassette('videos/find') do
          described_class.find(7574982)
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
        let(:changes) { { title: %w(video-mp4 new-title), description: %w(description new-desc)} }

        specify { expect(video).to be_changed }
        specify { expect(video.changed).to match_array changed }
        specify { expect(video.changed_attributes).to eq changed_attributes }
        specify { expect(video.changes).to eq changes }
      end
    end

    describe '.find' do
      context 'when the video can be found' do
        it 'finds the video' do
          VCR.use_cassette('videos/find') do
            video = described_class.find(7574982)
            expect(video.id).to eq 7574982
            expect(video.title).to eq 'video-mp4'
            expect(video.user_id).to eq 79357
            expect(video.account_id).to eq 79357
            expect(video.description).to eq 'description'
            expect(video.private).to eq false
            expect(video.seo_url).to eq 'seo-url'
            expect(video.url).to eq 'video-url'
            expect(video.thumbnail_url).to eq 'https://view.vzaar.localhost/7574982/thumb'
            expect(video.state).to eq 'ready'
            expect(video.categories.count).to eq 2
            expect(video.renditions.count).to eq 8
            expect(video.legacy_renditions.count).to eq 8
            expect(video.created_at).to eq '2016-12-01T17:27:12.000Z'
            expect(video.updated_at).to eq '2017-01-30T12:49:41.000Z'
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
          { guid: 't8dec9434bcc64622b68d1dc16f3ddffap' }
        end

        context 'and a new video is created' do
          it 'returns the new video' do
            VCR.use_cassette('videos/create/guid_201') do
              video = described_class.create(attrs)
              expect(video.id).to eq 7574982
            end
          end
        end

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
              expect(video.id).to eq 1293123212
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
              expect(video.id).to eq 1293123213
            end
          end
        end

        context 'and invalid params are provided' do
          it 'raises an error' do
            VCR.use_cassette('videos/create/link_error') do
              attrs.delete :uploader
              expect { described_class.create attrs }.to raise_error(
                Error, 'Invalid parameters: uploader is missing')
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

    describe '#delete' do
      context 'when video is deleted successfully' do
        it 'returns true' do
          VCR.use_cassette('videos/delete_204') do
            video = described_class.find(7574985)
            expect(video.delete).to eq true
            expect { described_class.find(7574985) }.
              to raise_error(Error, 'Not found: Resource cannot be found')
          end
        end
      end
    end

    describe '.paginate' do
      it 'loads the video collection' do
        VCR.use_cassette('videos/paginate_first') do
          pager = described_class.paginate(per_page: 3)
          pager.first
          ids = pager.collection.map { |video| video.id }
          expect(ids).to match_array [7574851, 7574852, 7574853]
        end
      end

      it 'loads the video collection' do
        VCR.use_cassette('videos/paginate_next') do
          pager = described_class.paginate(per_page: 3)
          pager.next
          ids = pager.collection.map { |video| video.id }
          expect(ids).to match_array [7574848, 7574849, 7574850]
        end
      end

      it 'loads the video collection' do
        VCR.use_cassette('videos/paginate_last') do
          pager = described_class.paginate(per_page: 3)
          pager.last
          ids = pager.collection.map { |video| video.id }
          expect(ids).to match_array [927938, 935900]
        end
      end

      it 'loads the video collection' do
        VCR.use_cassette('videos/paginate_previous') do
          pager = described_class.paginate(page: 4, per_page: 3)
          pager.previous
          ids = pager.collection.map { |video| video.id }
          expect(ids).to match_array [7574844, 7574845, 7574847]
        end
      end
    end

  end
end
