module VzaarApi
  module Signature
    describe Single do

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
            :"x-amz-credential" => "abc",
            :"x-amz-algorithm" => "alg",
            :"x-amz-date" => "date",
            :"x-amz-signature" => "sig"
          }
        end

        specify { expect(subject.access_key_id).to eq 'access_key_id' }
        specify { expect(subject.acl).to eq 'acl' }
        specify { expect(subject.bucket).to eq 'bucket' }
        specify { expect(subject.guid).to eq 'guid' }
        specify { expect(subject.key).to eq 'key' }
        specify { expect(subject.policy).to eq 'policy' }
        specify { expect(subject.success_action_status).to eq 'success_action_status' }
        specify { expect(subject.upload_hostname).to eq 'upload_hostname' }

        it_behaves_like "includes x-amz headers hash"
      end

      describe '#create' do
        context 'when successful' do
          let(:attrs) do
            { filename: 'video.mp4',
              filesize: 25165824,
              uploader: UPLOADER }
          end

          subject { described_class.create attrs }

          it 'builds a signature' do
            VCR.use_cassette('signature/single_201') do
              expect(subject.acl).to eq 'private'
              expect(subject.bucket).to eq 'vzaar-upload-development'
              expect(subject.guid).to eq "guid"
              expect(subject.key)
                .to eq "vzaar/twc/Kqm/source/twcKqmLoY-d4/${filename}"
              expect(subject.policy).to eq 'policy'
              expect(subject.success_action_status).to eq '201'
              expect(subject.upload_hostname)
                .to eq 'https://vzaar-upload-development.s3.amazonaws.com'
            end
          end

          it_behaves_like "assigns x-amz headers from response",
                          "signature/single_201"
        end

        context 'when unsuccessful' do
          it 'raises an error' do
            VCR.use_cassette('signature/single_422') do
              attrs = { filename: 'video.mp4' }
              expect { described_class.create attrs }.
                to raise_error(Error, 'Invalid parameters: uploader is missing')
            end
          end
        end
      end
    end
  end
end
