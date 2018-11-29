module VzaarApi
  module Upload
    describe S3 do
      subject { described_class.new attrs, signature }

      shared_examples "handling AWS error" do |cassette_name|
        it 'handles an AWS 403 error' do
          VCR.use_cassette(cassette_name) do
            err_msg = 'X-Amz-Date must be formated via ISO8601 Long format'
            expect { subject.execute }.to raise_error(Error, err_msg)
          end
        end
      end

      describe '#execute' do
        context 'when multipart' do
          let(:attrs) do
            { path: 'spec/support/files/video-12.0MB.mp4', title: 'video-title' }
          end

          let(:signature_attrs) do
            {
              key: "vzaar/tEW/AYG/source/tEWAYGhS8O5M/${filename}",
              acl: 'private',
              policy: "policy",
              success_action_status: '201',
              guid: "tEWAYGhS8O5M",
              bucket: 'vzaar-upload-development',
              upload_hostname: 'https://vzaar-upload-development.s3.amazonaws.com',
              part_size: '5MB',
              part_size_in_bytes: 5242880,
              parts: 3,
             :"x-amz-credential"=>"xxx/us-east-1/s3/aws4_request",
             :"x-amz-algorithm"=>"AWS4-HMAC-SHA256",
             :"x-amz-date"=>"date",
             :"x-amz-signature"=>"sig"}
          end

          let(:signature) do
            Signature::Multipart.new signature_attrs.merge(signature_attrs)
          end

          context 'when successful' do
            let(:expected_result) do
              { guid: "tEWAYGhS8O5M", title: 'video-title' }
            end

            it 'uploads the video file' do
              VCR.use_cassette('upload/multipart_201') do
                expect(subject.execute).to eq expected_result
              end
            end
          end

          context 'when unsuccessful' do
            it_behaves_like "handling AWS error", 'upload/multipart_403'

            it 'handles an unexpected error' do
              allow(subject)
                .to receive(:http_client).and_raise(SocketError, 'error message')
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
              key: "vzaar/tDQ/Upo/source/tDQUpoW-63JI/${filename}",
              acl: 'private',
              policy: "policy",
              success_action_status: '201',
              guid: "tDQUpoW-63JI",
              bucket: 'vzaar-upload-development',
              upload_hostname: 'https://vzaar-upload-development.s3.amazonaws.com',
              :"x-amz-credential"=> "xxxxx/us-east-1/s3/aws4_request",
              :"x-amz-algorithm"=>"AWS4-HMAC-SHA256",
              :"x-amz-date"=>"date",
              :"x-amz-signature"=>"signature"
            }
          end

          let(:signature) { Signature::Single.new signature_attrs }

          context 'when successful' do
            let(:expected_result) do
              { guid: "tDQUpoW-63JI", title: 'video-title' }
            end

            it 'uploads the video file' do
              VCR.use_cassette('upload/single_201') do
                expect(subject.execute).to eq expected_result
              end
            end
          end

          context 'when unsuccessful' do
            it_behaves_like "handling AWS error", 'upload/single_403'

            it 'handles an unexpected error' do
              allow(subject)
                .to(receive(:http_client))
                .and_raise(SocketError, 'error message')

              expect { subject.execute }.to raise_error(Error, 'error message')
            end
          end
        end
      end
    end
  end
end
