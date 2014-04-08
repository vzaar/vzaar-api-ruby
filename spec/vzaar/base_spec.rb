require 'spec_helper'

module Vzaar
  describe Base do

    subject { described_class.new options }

    let(:application_token) { 'b0v8p14Ugpx5zMgDf6leUOxSt8pkcGCFyBcsh0ugHg' }
    let(:force_http) { false }
    let(:login) { 'api-test-user' }
    let(:server) { 'vzaar.com' }
    let(:api) { double 'Api' }

    let(:options) do
      {
        application_token: application_token,
        force_http: false,
        login: login,
        server: server
      }
    end

    describe '#initialize' do
      context 'with valid options' do
        context 'using defaults' do
          let(:options) { {} }

          its(:application_token) { should == '' }
          its(:force_http) { should be_false }
          its(:login) { should == '' }
          its(:server) { should == server }
        end

        context 'overriding defaults' do
          let(:custom_server) { 'example.com' }
          before do
            options[:force_http] = true
            options[:server] = custom_server
          end

          its(:application_token) { should == application_token }
          its(:force_http) { should be_true }
          its(:login) { should == login }
          its(:server) { should == custom_server }
        end
      end

      it "creates a connection using the provided options" do
        merged_options = described_class::DEFAULTS.merge(options)
        Connection.should_receive(:new).with(merged_options).and_return('the connection')
        instance = described_class.new options
        expect(instance.connection).to eq('the connection')
      end

      it "creates an api instance using the connection" do
        merged_options = described_class::DEFAULTS.merge(options)
        Connection.stub(:new).and_return('the connection')
        Api.should_receive(:new).with('the connection').and_return('the api')
        instance = described_class.new options
        expect(instance.api).to eq('the api')
      end
    end

    describe '#whoami' do
      before { subject.stub(:api).and_return(api) }
      it 'delegates to the API' do
        api.should_receive(:whoami)
        subject.whoami
      end
    end

    describe '#account_type' do
      before { subject.stub(:api).and_return(api) }
      let(:id) { 123 }
      it 'delegates to the API' do
        api.should_receive(:account_type).with(id)
        subject.account_type(id)
      end
    end

    describe '#user_details' do
      before { subject.stub(:api).and_return(api) }

      context 'accepting defaults' do
        let(:authenticated) { false }
        it 'delegates to the API' do
          api.should_receive(:user_details).with(login, authenticated)
          subject.user_details(login)
        end
      end

      context 'overriding defaults' do
        let(:authenticated) { true }
        it 'delegates to the API' do
          api.should_receive(:user_details).with(login, authenticated)
          subject.user_details(login, authenticated)
        end
      end
    end

    describe '#video_details' do
      before { subject.stub(:api).and_return(api) }
      let(:id) { 123 }

      context 'accepting defaults' do
        let(:authenticated) { false }
        it 'delegates to the API' do
          api.should_receive(:video_details).with(id, authenticated)
          subject.video_details(id)
        end
      end

      context 'overriding defaults' do
        let(:authenticated) { true }
        it 'delegates to the API' do
          api.should_receive(:video_details).with(id, authenticated)
          subject.video_details(id, authenticated)
        end
      end
    end

    describe '#video_list' do
      before { subject.stub(:api).and_return(api) }

      context 'accepting defaults' do
        let(:authenticated) { false }
        let(:page) { 1 }
        it 'delegates to the API' do
          api.should_receive(:video_list).with(login, authenticated, page)
          subject.video_list(login)
        end
      end

      context 'overriding defaults' do
        let(:authenticated) { true }
        let(:page) { 2 }
        it 'delegates to the API' do
          api.should_receive(:video_list).with(login, authenticated, page)
          subject.video_list(login, authenticated, page)
        end
      end
    end

    describe '#videos' do
      let(:authenticated) { true }

      context 'accepting defaults' do
        let(:page) { 1 }
        it 'delegates to #video_list' do
          subject.should_receive(:video_list).with(login, authenticated, page)
          subject.videos
        end
      end

      context 'overriding defaults' do
        let(:page) { 2 }
        it 'delegates to #video_list' do
          subject.should_receive(:video_list).with(login, authenticated, page)
          subject.videos(page)
        end
      end
    end

    describe '#delete_video' do
      before { subject.stub(:api).and_return(api) }
      let(:id) { 123 }
      it 'delegates to the API' do
        api.should_receive(:delete_video).with(id)
        subject.delete_video(id)
      end
    end

    describe '#edit_video' do
      before { subject.stub(:api).and_return(api) }
      let(:id) { 123 }
      let(:options) { { title: 'title' } }

      it 'delegates to the API' do
        api.should_receive(:edit_video).with(id, options)
        subject.edit_video(id, options)
      end
    end

    describe '#signature' do
      before { subject.stub(:api).and_return(api) }
      let(:options) { { :key => 123 } }

      it 'delegates to the API' do
        api.should_receive(:signature).with(options)
        subject.signature(options)
      end
    end

    describe '#upload_video' do
      before { subject.stub(:api).and_return(api) }
      let(:path) { 'path/to/video.mp4' }

      context 'accepting defaults' do
        let(:upload_options) { {} }
        it 'delegates to the API' do
          api.should_receive(:upload_video).with(path, upload_options)
          subject.upload_video(path)
        end
      end

      context 'overriding defaults' do
        let(:upload_options) do
          {
            title: 'title',
            desc: 'desc',
            profile: '2',
            transcoding: 'transcoding'
          }
        end

        it 'delegates to the API' do
          api.should_receive(:upload_video).with(path, upload_options)
          subject.upload_video(path, upload_options)
        end
      end
    end

  end
end
