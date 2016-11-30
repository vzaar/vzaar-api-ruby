require_relative './../spec_helper'

module VzaarApi
  describe 'Video: Create' do

    let(:described_class) { Video }

    context 'when user is authenticated' do
      before { setup_for :account_owner }

      context 'when doing a single-part upload' do
        it 'creates the video' do
          attrs = { title: "single: #{Time.now.utc}", path: 'examples/support/videos/small.mp4' }
          video = described_class.create(attrs)
          expect(video.title).to eq attrs[:title]
        end
      end

      context 'when doing a multi-part upload' do
        it 'creates the video' do
          attrs = { title: "multi-part: #{Time.now.utc}", path: 'examples/support/videos/medium.mp4' }
          video = described_class.create(attrs)
          expect(video.title).to eq attrs[:title]
        end
      end

      context 'when doing a multi-part upload with a non-default ingest recipe' do
        it 'creates the video' do
          attrs = { title: "custom-recipe: #{Time.now.utc}",
            ingest_recipe_id: api_envs['ingest_recipe']['other'],
            path: 'examples/support/videos/medium.mp4' }
          video = described_class.create(attrs)
          expect(video.title).to eq attrs[:title]
        end
      end

      context 'when doing a link upload' do
        it 'creates the video' do
          attrs = { title: "link: #{Time.now.utc}", url: 'https://www.dropbox.com/s/zu1n51dm9sabogq/dropbox-video.mp4?dl=0' }
          video = described_class.create(attrs)
          expect(video.title).to eq attrs[:title]
        end
      end
    end

    context 'when user is not authenticated' do
      before { setup_for :intruder }

      it 'raises an error' do
        attrs = { path: 'examples/support/videos/small.mp4' }
        expect{ described_class.create(attrs) }.to raise_error(
          Error, 'Authentication failed: Invalid credentials')
      end
    end

  end
end
