require 'spec_helper'

module Vzaar
  describe Uploader do
    let(:conn) { double }
    let(:signature_hash) { double }
    let(:path) { double }
    let(:opts) do
      { url: url, path: path }
    end

    subject { described_class.new(conn, signature_hash, opts) }

    describe "#upload" do
      let(:uploader) { double }

      describe "standard upload directly to s3" do
        let(:url) { nil }

        specify do
          allow(Uploaders::S3).to receive(:new)
            .with(opts[:path], signature_hash) { uploader }

          allow(uploader).to receive(:upload)
          subject.upload
        end
      end

      describe "link upload" do
        let(:url) { double }

        specify do


          pending


          allow(Uploaders::Link).to receive(:new)
            .with(conn, signature_hash, opts) { uploader }

          allow(uploader).to receive(:upload)
          subject.upload
        end
      end

    end
  end
end
