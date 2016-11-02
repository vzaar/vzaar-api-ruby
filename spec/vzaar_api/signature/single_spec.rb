module VzaarApi::Signature
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
          upload_hostname: 'upload_hostname'
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
    end

  end
end
