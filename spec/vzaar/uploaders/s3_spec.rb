require 'spec_helper'

module Vzaar
  describe Uploaders::S3 do

    subject { described_class.new path, signature }

    let(:path) { './spec/support/video.mov' }
    let(:signature) { double chunk_size: chunk_size }

    describe '#upload' do
      context 'and chunk_size is nil' do
        let(:chunk_size) { nil }

        it 'performs a single part upload' do
          expect(subject).to receive(:single_part_upload)
          subject.upload
        end
      end

      context 'and chunk_size is blank' do
        let(:chunk_size) { '' }

        it 'performs a single part upload' do
          expect(subject).to receive(:single_part_upload)
          subject.upload
        end
      end

      context 'and chunk_size is present' do
        let(:chunk_size) { '32mb' }

        it 'performs a single part upload' do
          expect(subject).to receive(:multipart_upload)
          subject.upload
        end
      end
    end
  end
end
