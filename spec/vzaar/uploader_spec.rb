require 'spec_helper'

module Vzaar
  describe Uploader do
    let(:conn) { double }
    let(:guid) { double }
    let(:key) { double }
    let(:signature) { double(guid: guid, key: key) }
    let(:path) { double }
    let(:opts) do
      { url: url, path: path }
    end

    subject { described_class.new(conn, signature, opts) }

    describe "#upload" do
      let(:uploader) { double }

      describe "standard upload directly to s3" do
        let(:url) { nil }

        specify do
          allow(Uploaders::S3).to receive(:new)
            .with(opts[:path], signature) { uploader }

          allow(uploader).to receive(:upload)
          subject.upload
        end
      end

      describe "link upload" do
        let(:url) { double }

        specify do
          expected_opts = opts.merge({ guid: guid, key: key })
          allow(Request::LinkUpload).to receive(:new)
            .with(conn, expected_opts) { uploader }

          allow(uploader).to receive(:execute)
          subject.upload
        end
      end

    end
  end
end
