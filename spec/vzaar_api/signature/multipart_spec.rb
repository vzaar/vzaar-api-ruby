module VzaarApi::Signature
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

  end
end
