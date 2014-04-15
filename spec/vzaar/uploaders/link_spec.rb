require 'spec_helper'

module Vzaar
  module Uploaders
    describe Link do
      let(:conn) { double }
      let(:signature) { double }
      let(:opts) { {} }

      subject { described_class.new(conn, signature, opts) }

      describe "setting timeout based on filesize" do
        let(:status) { "finished" }
        let(:progress) { 10 }
        let(:link_upload) { double }

        let(:upload_status) do
          double(filesize: filesize, progress: progress, status: status)
        end

        before do
          subject.stub(:upload_params) { link_upload }
          allow(Request::LinkUpload).to receive(:new) { link_upload }
          allow(link_upload).to receive(:execute)

          subject.stub(:get_upload_status) { upload_status }
          subject.upload
        end

        context "when video size < 10 MB" do
          let(:filesize) { 9999999 }
          specify { expect(subject.instance_variable_get(:@timeout)).to eq(10) }
        end

        context "when video size < 100 MB" do
          let(:filesize) { 99999999 }
          specify { expect(subject.instance_variable_get(:@timeout)).to eq(30) }
        end

        context "when video size < 1 GB" do
          let(:filesize) { 999999999 }
          specify { expect(subject.instance_variable_get(:@timeout)).to eq(60) }
        end

        context "when video size > 1 GB" do
          let(:filesize) { 1000000001 }
          specify { expect(subject.instance_variable_get(:@timeout)).to eq(120) }
        end
      end
    end
  end
end
