require_relative './../spec_helper'

module VzaarApi
  describe 'Playlist: Create / Update / Delete' do

    let(:described_class) { Playlist }

    context 'when user is authenticated' do
      before { setup_for :account_owner }

      let(:attrs) { { title: 'new SDK playlist', category_id: api_envs['category_id'] } }

      context "missing required parameters" do
        it "errors out" do
          expect{described_class.create}.to raise_error(
            Error, "Invalid parameters: title is missing, category_id is missing"
          )
        end
      end

      it 'creates, updates and deletes a playlist' do
        # create new playlist
        playlist = described_class.create attrs
        expect(playlist.title).to eq attrs[:title]
        expect(playlist.category_id).to eq attrs[:category_id]
        expect(playlist.max_vids).to eq 10
        expect(playlist.sort_by).to eq 'created_at'
        expect(playlist.sort_order).to eq 'desc'
        expect(playlist.private).to be_truthy
        expect(playlist.dimensions).to eq 'auto'
        expect(playlist.position).to eq 'left'
        expect(playlist.autoplay).to be_falsey
        expect(playlist.continuous_play).to be_falsey
        expect(playlist.embed_code).to match(
          "<iframe id=\"vzpl-#{playlist.id}\" name=\"vzpl-#{playlist.id}\" " \
          "title=\"vzaar video player\" class=\"vzaar video player\" " \
          "type=\"text/html\" width=\"927\" height=\"432\" frameborder=\"0\" " \
          "allowFullScreen allowTransparency=\"true\" mozallowfullscreen " \
          "webkitAllowFullScreen src=\"//view.vzaar.localhost/playlists/#{playlist.id}\">" \
          "</iframe>"
        )

        # reload the playlist
        playlist = described_class.find(playlist.id)

        # update the playlist
        expect(playlist).not_to be_changed
        new_title = playlist.title = "(updated): #{Time.now.utc}"
        playlist.max_vids = 11
        playlist.sort_by = 'title'
        playlist.sort_order = 'asc'
        playlist.private = false
        playlist.dimensions = '400x200'
        playlist.position = 'top'
        playlist.autoplay = true
        playlist.continuous_play = true

        expect(playlist).to be_changed
        playlist.save
        expect(playlist).not_to be_changed

        expect(playlist.title).to eq new_title
        expect(playlist.max_vids).to eq 11
        expect(playlist.sort_by).to eq 'title'
        expect(playlist.sort_order).to eq 'asc'
        expect(playlist.private).to be_falsey
        expect(playlist.dimensions).to eq '400x200'
        expect(playlist.position).to eq 'top'
        expect(playlist.autoplay).to be_truthy
        expect(playlist.continuous_play).to be_truthy
        expect(playlist.embed_code).to match(
          "<iframe id=\"vzpl-#{playlist.id}\" name=\"vzpl-#{playlist.id}\" " \
          "title=\"vzaar video player\" class=\"vzaar video player\" " \
          "type=\"text/html\" width=\"400\" height=\"330\" frameborder=\"0\" " \
          "allowFullScreen allowTransparency=\"true\" mozallowfullscreen " \
          "webkitAllowFullScreen src=\"//view.vzaar.localhost/playlists/#{playlist.id}\">" \
          "</iframe>"
        )

        # delete the playlist
        playlist.delete
        expect{ described_class.find(playlist.id) }.to raise_error(
          Error, 'Not found: Resource cannot be found')
      end
    end

    context 'when user is not authenticated' do
      before { setup_for :intruder }
      let(:attrs) { { title: 'no', category_id: 2253 } }

      it 'raises an error' do
        expect{ described_class.create(attrs) }.to raise_error(
          Error, 'Authentication failed: Invalid credentials')
      end
    end
  end
end
