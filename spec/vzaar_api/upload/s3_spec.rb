module VzaarApi
  module Upload
    describe S3 do

      subject { described_class.new attrs, signature }

      describe '#execute' do
        context 'when multipart' do
          let(:attrs) do
            { path: 'spec/support/files/video-12.0MB.mp4', title: 'video-title' }
          end

          let(:signature_attrs) do
            {
              access_key_id: 'access_key_id',
              key: 'vzaar/t22/063/source/t22063bd228834adc8b9c7d5fb320b2b3o/${filename}',
              acl: 'private',
              policy: 'policy',
              signature: 'signature',
              success_action_status: '201',
              content_type: 'binary/octet-stream',
              guid: 't22063bd228834adc8b9c7d5fb320b2b3o',
              bucket: 'vzaar-upload-development',
              upload_hostname: 'https://vzaar-upload-development.s3.amazonaws.com',
              part_size: '5MB',
              part_size_in_bytes: 5242880,
              parts: 3
            }
          end

          let(:signature) { Signature::Multipart.new signature_attrs.merge(signature_attrs) }

          context 'when successful' do
            let(:expected_result) do
              { guid: 't22063bd228834adc8b9c7d5fb320b2b3o', title: 'video-title' }
            end

            it 'uploads the video file' do
              VCR.use_cassette('upload/multipart_201') do
                expect(subject.execute).to eq expected_result
              end
            end
          end

          context 'when unsuccessful' do
            it 'handles an AWS 403 error' do
              VCR.use_cassette('upload/multipart_403') do
                expect { subject.execute }.to raise_error(
                  Error, 'The AWS Access Key Id you provided does not exist in our records.')
              end
            end

            it 'handles an unexpected error' do
              allow(subject).to receive(:http_client).and_raise(SocketError, 'error message')
              expect { subject.execute }.to raise_error(Error, 'error message')
            end
          end
        end

        context 'when single' do
          let(:attrs) do
            { path: 'spec/support/files/video-1.0MB.mp4', title: 'video-title' }
          end

          let(:signature_attrs) do
            {
              access_key_id: 'access_key_id',
              key: "vzaar/t20/d72/source/t20d722afb9294989bda5f7cf01b11346v/${filename}",
              acl: 'private',
              policy: 'policy',
              signature: 'signature',
              success_action_status: "201",
              content_type: "binary/octet-stream",
              guid: "t20d722afb9294989bda5f7cf01b11346v",
              bucket: "vzaar-upload-development",
              upload_hostname: "https://vzaar-upload-development.s3.amazonaws.com"
            }
          end

          let(:signature) { Signature::Single.new signature_attrs }

          context 'when successful' do
            let(:expected_result) do
              { guid: 't20d722afb9294989bda5f7cf01b11346v', title: 'video-title' }
            end

            it 'uploads the video file' do
              VCR.use_cassette('upload/single_201') do
                expect(subject.execute).to eq expected_result
              end
            end
          end

          context 'when unsuccessful' do
            it 'handles an AWS 403 error' do
              VCR.use_cassette('upload/single_403') do
                expect { subject.execute }.to raise_error(
                  Error, 'The AWS Access Key Id you provided does not exist in our records.')
              end
            end

            it 'handles an unexpected error' do
              allow(subject).to receive(:http_client).and_raise(SocketError, 'error message')
              expect { subject.execute }.to raise_error(Error, 'error message')
            end
          end
        end
      end

    end
  end
end
