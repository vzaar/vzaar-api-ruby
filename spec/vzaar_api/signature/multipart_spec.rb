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
            parts: 'parts'
          }
        end

        specify { expect(subject.access_key_id).to eq 'access_key_id' }
        specify { expect(subject.acl).to eq 'acl' }
        specify { expect(subject.bucket).to eq 'bucket' }
        specify { expect(subject.content_type).to eq 'content_type' }
        specify { expect(subject.guid).to eq 'guid' }
        specify { expect(subject.key).to eq 'key' }
        specify { expect(subject.policy).to eq 'policy' }
        specify { expect(subject.signature).to eq 'signature' }
        specify { expect(subject.success_action_status).to eq 'success_action_status' }
        specify { expect(subject.upload_hostname).to eq 'upload_hostname' }
        specify { expect(subject.part_size).to eq 'part_size' }
        specify { expect(subject.part_size_in_bytes).to eq 'part_size_in_bytes' }
        specify { expect(subject.parts).to eq 'parts' }
      end

      describe '#create' do
        context 'when successful' do
          it 'builds a signature' do
            VCR.use_cassette('signature/multipart_201') do
              attrs = { filename: 'video.mp4', filesize: 25165824, uploader: UPLOADER }
              signature = described_class.create attrs
              expect(signature.access_key_id).to eq 'access_key_id'
              expect(signature.acl).to eq 'private'
              expect(signature.bucket).to eq 'vzaar-upload-development'
              expect(signature.content_type).to eq 'binary/octet-stream'
              expect(signature.guid).to eq 'guid'
              expect(signature.key).to eq 'vzaar/t8d/ec9/source/t8dec9434bcc64622b68d1dc16f3ddffap/${filename}'
              expect(signature.policy).to eq 'policy'
              expect(signature.signature).to eq 'signature'
              expect(signature.success_action_status).to eq '201'
              expect(signature.upload_hostname).to eq 'https://vzaar-upload-development.s3.amazonaws.com'
              expect(signature.part_size).to eq '5MB'
              expect(signature.part_size_in_bytes).to eq 5242880
              expect(signature.parts).to eq 5
            end
          end
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
