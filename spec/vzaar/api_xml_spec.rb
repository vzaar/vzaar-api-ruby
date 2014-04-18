require 'spec_helper'

module Vzaar
  describe Api do

    subject { described_class.new connection }
    let(:connection) { Connection.new options }

    let(:application_token) { 'b0v8p14Ugpx5zMgDf6leUOxSt8pkcGCFyBcsh0ugHg' }
    let(:force_http) { false }
    let(:login) { 'api-test-user' }
    let(:server) { 'vzaar.com' }

    let(:options) do
      {
        application_token: application_token,
        force_http: false,
        login: login,
        server: server
      }
    end

    its(:conn) { should == connection }

    describe "#whoami" do
      context "with valid credentials" do
        it "returns the user login" do
          VCR.use_cassette('whoami-success') do
            expect(subject.whoami).to eq(login)
          end
        end
      end

      context "with invalid credentials" do
        let(:application_token) { 'invalid' }
        it "raises an error" do
          VCR.use_cassette('whoami-fail') do
            expect { subject.whoami }.to raise_error(
              VzaarError, VzaarError::PROTECTED_RESOURCE)
          end
        end
      end
    end

    describe "#account_type" do
      context "with a valid id" do
        let(:account_type_id) { '100' }
        it "returns the account type details" do
          VCR.use_cassette('account_type-success') do
            account_type = subject.account_type(account_type_id)
            expect(account_type.id).to eq(account_type_id.to_i)
          end
        end
      end

      context "with an invalid id" do
        let(:account_type_id) { '-1' }
        it "raises an error" do
          VCR.use_cassette('account_type-fail') do
            expect { subject.account_type(account_type_id) }.to raise_error(
              VzaarError, VzaarError::NOT_FOUND)
          end
        end
      end
    end

    describe "#user_details" do
      shared_examples 'user_details' do
        context "with a valid login" do
          it "returns the user details" do
            VCR.use_cassette("#{vcr_cassette}-success") do
              user = subject.user_details(login, authenticated: authentication)
              expect(user.name).to eq(login)
            end
          end
        end

        context "with an invalid login" do
          let(:login) { '0000000000000000' }
          it "raises an error" do
            VCR.use_cassette("#{vcr_cassette}-fail") do
              expect { subject.user_details(login, authenticated: authentication) }
                .to raise_error(VzaarError, VzaarError::NOT_FOUND)
            end
          end
        end
      end

      context "with authentication" do
        let(:authentication) { true }
        let(:vcr_cassette) { 'user_details-authenticated' }
        it_behaves_like 'user_details'
      end

      context "without authentication" do
        let(:authentication) { false }
        let(:vcr_cassette) { 'user_details-public' }
        it_behaves_like 'user_details'
      end
    end

    describe "#video_details" do
      shared_examples 'a successful video_details request' do
        it "returns the video details" do
          VCR.use_cassette("#{vcr_cassette}-success") do
            video = subject.video_details(video_id, authenticated: authentication)
            expect(video.html).to include("#{video_id}")
          end
        end
      end

      shared_examples 'a video_details resource that cannot be found' do
        it "raises an error" do
          VCR.use_cassette("#{vcr_cassette}-fail") do
            expect { subject.video_details(video_id, authenticated: authentication) }.to raise_error(
              VzaarError, VzaarError::NOT_FOUND)
          end
        end
      end

      shared_examples 'a video_details resource that is protected' do
        it "raises an error" do
          VCR.use_cassette("#{vcr_cassette}-success") do
            expect { subject.video_details(video_id, authenticated: authentication) }
              .to raise_error(VzaarError, VzaarError::PROTECTED_RESOURCE)
          end
        end
      end

      context "for a private video" do
        let(:video_id) { 1403914 }

        context "with authentication" do
          let(:authentication) { true }
          let(:vcr_cassette) { 'video_details-pvt-authenticated' }
          it_behaves_like 'a successful video_details request'
        end

        context "without authentication" do
          let(:authentication) { false }
          let(:vcr_cassette) { 'video_details-pvt-public' }
          it_behaves_like 'a video_details resource that is protected'
        end
      end

      context "for a public video" do
        let(:video_id) { 1403915 }

        context "with authentication" do
          let(:authentication) { true }
          let(:vcr_cassette) { 'video_details-pub-authenticated' }
          it_behaves_like 'a successful video_details request'
        end

        context "without authentication" do
          let(:authentication) { false }
          let(:vcr_cassette) { 'video_details-pub-public' }
          it_behaves_like 'a successful video_details request'
        end
      end

      context "for a video that cannot be found" do
        let(:video_id) { -1 }

        context "with authentication" do
          let(:authentication) { true }
          let(:vcr_cassette) { 'video_details-pub-authenticated' }
          it_behaves_like 'a video_details resource that cannot be found'
        end

        context "without authentication" do
          let(:authentication) { false }
          let(:vcr_cassette) { 'video_details-pub-public' }
          it_behaves_like 'a video_details resource that cannot be found'
        end
      end
    end

    describe "#video_list" do
      context "with authentication" do
        let(:authentication) { true }
        it "returns a collection of private and public videos" do
          VCR.use_cassette("video_list-pvt-success") do
            videos = subject.video_list(login, { authenticated: authentication })
            expect(videos.count).to eq(2)
          end
        end
      end

      context "without authentication" do
        let(:authentication) { false }
        it "returns a collection of public videos only" do
          VCR.use_cassette("video_list-pub-success") do
            videos = subject.video_list(login, { authenticated: authentication })
            expect(videos.count).to eq(1)
          end
        end
      end
    end

    describe "#videos" do
      it "returns a collection of private and public videos" do
        VCR.use_cassette("video_list-pvt-success") do
          videos = subject.videos
          expect((videos.count)).to eq(2)
        end
      end
    end

    describe "#delete_video" do
      context "for a video that I own" do
        let(:video_id) { 1405081 }

        context "when the video can be deleted" do
          it "deletes the video" do
            VCR.use_cassette("delete_video-success") do
              res = subject.delete_video(video_id)
              expect(res.html).to include("#{video_id}")
            end
          end
        end

        context "when the video is already deleted" do
          it "raises an error" do
            VCR.use_cassette("delete_video-retry-success") do
              expect { subject.delete_video(video_id) }.to raise_error(
                VzaarError, VzaarError::NOT_FOUND)
            end
          end
        end
      end

      context "for a video that belongs to another user" do
        let(:video_id) { 1405106 }
        it "raises an error" do
          VCR.use_cassette("delete_video-fail") do
            expect { subject.delete_video(video_id) }.to raise_error(
              VzaarError, VzaarError::UNKNOWN)
          end
        end
      end

      context "for an invalid video id" do
        let(:video_id) { -1 }
        it "raises an error" do
          VCR.use_cassette("delete_video-not-found") do
            expect { subject.delete_video(video_id) }.to raise_error(
              VzaarError, VzaarError::NOT_FOUND)
          end
        end
      end
    end

    describe "#edit_video" do
      let(:edit_options) { { title: 'new title', description: 'some description' } }

      context "for a video I own" do
        let(:video_id) { 1405081 }
        it "updates the title and description" do
          VCR.use_cassette("edit_video-success") do
            video = subject.edit_video(video_id, edit_options)
            expect(video.title).to eq(edit_options[:title])
          end
        end
      end

      context "for a video that belongs to another user" do
        let(:video_id) { 1405106 }
        it "raises an error" do
          VCR.use_cassette("edit_video-fail") do
            expect { subject.edit_video(video_id, edit_options) }.to raise_error(
              VzaarError, VzaarError::UNKNOWN)
          end
        end
      end

      context "for an invalid video id" do
        let(:video_id) { -1 }
        it "updates the title and description" do
          VCR.use_cassette("edit_video-not-found") do
            expect { subject.edit_video(video_id, edit_options) }.to raise_error(
              VzaarError, VzaarError::NOT_FOUND)
          end
        end
      end
    end

    describe "#signature" do
      context "with default options" do
        let(:signature_options) { {} }
        it "returns a signature" do
          VCR.use_cassette("signature-default") do
            signature = subject.signature
            expect(signature.https).to be_false
          end
        end
      end

      context "with custom options" do
        let(:signature_options) do
          {
            success_action_redirect: 'example.com',
            include_metadata: true,
            flash: false
          }
        end

        it "returns a signature" do
          VCR.use_cassette("signature-with-options") do
            signature = subject.signature signature_options
            expect(signature.https).to be_false
          end
        end
      end
    end

    describe "#upload_video" do
      let(:expected_video_id) { '1407683' }
      let(:path) { './spec/support/video.mp4' }
      let(:upload_options) do
        { title: 'title', description: 'desc', profile: '2', path: path }
      end

      it "uploads the video, starts processing and returns the video id" do
        VCR.use_cassette('upload_video-success') do
          video = subject.upload_video(upload_options)
          expect(video.id).to eq(expected_video_id.to_i)
        end
      end
    end

    describe "#process_video" do
      let(:expected_video_id) { '1407672' }

      let(:process_options) do
        {
          guid: 'vze7355b904a904737ab0e9582045c78ff',
          title: 'new video',
          description: 'a very long description',
          profile: '2'
        }
      end

      it "returns the video id" do
        VCR.use_cassette('process_video-default') do
          video = subject.process_video process_options
          expect(video.id).to eq(expected_video_id.to_i)
        end
      end
    end

  end
end
