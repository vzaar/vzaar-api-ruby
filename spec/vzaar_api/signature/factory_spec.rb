module VzaarApi
  module Signature
    describe Factory do

      subject { described_class.new attrs }

      let(:attrs) do
        { path: './spec/support/files/video-5.0MB.mp4' }
      end

      describe '.create' do
        before do
          allow(described_class).to receive(:new).with(attrs) { instance }
        end

        let(:instance) { double create: true }
        let(:result) { described_class.create attrs }
        specify { expect(result).to be true }
      end

      describe '#create' do
        before do
          allow(subject).to receive(:multipart?) { multipart }
          allow(Multipart).to receive(:create).with(multipart_attrs) { 'multipart' }
          allow(Single).to receive(:create).with(multipart_attrs) { 'single' }
        end

        let(:multipart_attrs) do
          {
            filesize: 5242880,
            filename: 'video-5.0MB.mp4'
          }
        end

        context 'when multipart' do
          let(:multipart) { true }
          specify { expect(subject.create).to eq 'multipart' }
        end

        context 'when single' do
          let(:multipart) { false }
          specify { expect(subject.create).to eq 'single' }
        end
      end

      describe '#multipart?' do
        context 'when multipart params are provided' do
          let(:attrs) { { path: './spec/support/files/video-5.0MB.mp4' } }
          specify { expect(subject.multipart?).to be true }
        end

        context 'when non-multipart params are provided' do
          let(:attrs) { { path: './spec/support/files/video-4.9MB.mp4' } }
          specify { expect(subject.multipart?).to be false }
        end

        context 'when invalid params are provided' do
          let(:attrs) { { path: './no/file/here.mp4' } }
          it 'raises an error' do
            expect { subject.multipart? }.to raise_error(
              Error, 'Invalid parameters: path is invalid')
          end
        end
      end

    end
  end
end
