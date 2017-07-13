module VzaarApi
  describe Playlist do

    before { setup_auth! }

    describe '.find' do
      context 'when the playlist can be found' do
        it 'finds the playlist' do
          VCR.use_cassette 'playlists/find' do
            playlist = described_class.find(12692)
            expect(playlist.id).to eq 12692
            expect(playlist.category_id).to eq 2253
            expect(playlist.max_vids).to eq 43
            expect(playlist.title).to eq 'test'
            expect(playlist.sort_by).to eq 'created_at'
            expect(playlist.sort_order).to eq 'desc'
            expect(playlist.private).to be_falsey
            expect(playlist.dimensions).to eq '768x340'
            expect(playlist.position).to eq 'right'
            expect(playlist.autoplay).to be_truthy
            expect(playlist.continuous_play).to be_truthy
            expect(playlist.embed_code).to match(
              "<iframe id=\"vzpl-12692\" name=\"vzpl-12692\" " \
              "title=\"vzaar video player\" class=\"vzaar video player\" " \
              "type=\"text/html\" width=\"927\" height=\"340\" frameborder=\"0\" " \
              "allowFullScreen allowTransparency=\"true\" mozallowfullscreen " \
              "webkitAllowFullScreen src=\"//view.vzaar.localhost/playlists/12692\">" \
              "</iframe>"
            )
            expect(playlist.created_at).to eq "2017-04-21T14:16:50.000Z"
            expect(playlist.updated_at).to eq "2017-04-21T14:16:50.000Z"
          end
        end
      end

      context 'when the playlist cannot be found' do
        it 'raises an error' do
          VCR.use_cassette('playlists/find_404') do
            expect { described_class.find(-1) }.
              to raise_error(Error, 'Not found: Resource cannot be found')
          end
        end
      end
    end

    describe '.each_item' do
      it 'loads the playlist collection' do
        VCR.use_cassette('playlists/each_item') do
          enum = described_class.each_item(per_page: 2)
          ids = enum.map { |playlist| playlist.id }
          expect(ids).to match_array [
            12, 1065, 12676, 12677, 12678, 12679, 12680, 12681, 12682, 12683,
            12684, 12685, 12686, 12687, 12688, 12689, 12691, 12692
          ]
        end
      end
    end

    describe '.paginate' do
      it 'loads the playlist collection' do
        VCR.use_cassette('playlists/paginate_first') do
          pager = described_class.paginate(per_page: 3)
          pager.first
          ids = pager.collection.map { |playlist| playlist.id }
          expect(ids).to match_array [12, 12676, 12677]
        end
      end

      it 'loads the playlist collection' do
        VCR.use_cassette('playlists/paginate_next') do
          pager = described_class.paginate(per_page: 3)
          pager.next
          ids = pager.collection.map { |playlist| playlist.id }
          expect(ids).to match_array [12678, 12679, 12680]
        end
      end

      it 'loads the playlist collection' do
        VCR.use_cassette('playlists/paginate_last') do
          pager = described_class.paginate(per_page: 3)
          pager.last
          ids = pager.collection.map { |playlist| playlist.id }
          expect(ids).to match_array [1065, 12691, 12692]
        end
      end

      it 'loads the playlist collection' do
        VCR.use_cassette('playlists/paginate_previous') do
          pager = described_class.paginate(page: 4, per_page: 3)
          pager.previous
          ids = pager.collection.map { |playlist| playlist.id }
          expect(ids).to match_array [12681, 12682, 12683]
        end
      end
    end
  end
end
