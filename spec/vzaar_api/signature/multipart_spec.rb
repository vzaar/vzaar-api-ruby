module VzaarApi
  module Signature
    describe Multipart do

      before do
        setup_auth!
      end

      describe '#initialize' do
        subject { described_class.new attrs }

        let(:attrs) do
          {
            access_key_id: 'access_key_id',
            acl: 'acl',
            bucket: 'bucket',
            content_type: 'content_type',
            guid: 'guid',
            key: 'key',
            policy: 'policy',
            signature: 'signature',
            success_action_status: 'success_action_status',
            upload_hostname: 'upload_hostname',
            part_size: 'part_size',
            part_size_in_bytes: 'part_size_in_bytes',
            parts: 'parts',
            upload_hostname: 'upload_hostname',
           :"x-amz-credential" => "abc",
           :"x-amz-algorithm" => "alg",
           :"x-amz-date" => "date",
           :"x-amz-signature" => "sig"
          }
        end

        specify { expect(subject.acl).to eq 'acl' }
        specify { expect(subject.bucket).to eq 'bucket' }
        specify { expect(subject.guid).to eq 'guid' }
        specify { expect(subject.key).to eq 'key' }
        specify { expect(subject.policy).to eq 'policy' }
        specify { expect(subject.success_action_status)
                    .to eq 'success_action_status' }
        specify { expect(subject.upload_hostname).to eq 'upload_hostname' }
        specify { expect(subject.part_size).to eq 'part_size' }
        specify { expect(subject.part_size_in_bytes)
                    .to eq 'part_size_in_bytes' }
        specify { expect(subject.parts).to eq 'parts' }

        it_behaves_like "includes x-amz headers hash"
      end

      describe '#create' do
        let(:attrs) do
          { filename: 'video.mp4',
            filesize: 25165824,
            uploader: UPLOADER }
        end

        subject { described_class.create attrs }

        context 'when successful' do
          it 'builds a signature' do
            VCR.use_cassette('signature/multipart_201') do
              expect(subject.acl).to eq 'private'
              expect(subject.bucket).to eq 'vzaar-upload-staging'
              expect(subject.guid.length).to eq 12
              expect(subject.key)
                .to eq "vzaar/#{subject.guid[0..2]}/#{subject.guid[3..5]}/source/#{subject.guid}/${filename}"
              expect(subject.policy.length).to eq 520
              expect(subject.success_action_status).to eq '201'
              expect(subject.upload_hostname).to eq 'https://vzaar-upload-staging.s3.amazonaws.com'
              expect(subject.part_size).to eq '16MB'
              expect(subject.part_size_in_bytes).to eq 16777216
              expect(subject.parts).to eq 2
            end
          end

          it_behaves_like "assigns x-amz headers from response",
                          "signature/multipart_201"
        end

        context 'when unsuccessful' do
          it 'raises an error' do
            VCR.use_cassette('signature/multipart_422') do
              attrs = { filename: 'video.mp4', filesize: nil, uploader: UPLOADER }
              expect { described_class.create attrs }.
                to raise_error(Error, 'Invalid parameters: Filesize must be between 5MB and 5TB')
            end
          end
        end
      end

    end
  end
end
