require 'spec_helper'

module Vzaar::Resource
  describe Signature do
    subject { described_class.new(xml) }

    context "when xml is returned" do
      let(:https) { false }
      let(:signature) { '7BOi7ogK5EEacIwHX56NTUSFCVk=' }
      let(:expiration_date) { '2013-11-22T19:53:12.000Z' }
      let(:acl) { 'private' }
      let(:success_action_redirect) { 'example.com?guid=vz83a21715f11048d89c0a5cf51c14b4df' }
      let(:profile) { '' }
      let(:policy) { 'ewogICAgICAgICdleHBpcmF0aW9uJzogJzIwMTMtMTEtMjJUMTk6NTM6MTIuMDAwWicsCiAgICAgICAgJ2NvbmRpdGlvbnMnOiBbCiAgICAgICAgICB7J2J1Y2tldCc6ICd2ejEnfSwKICAgICAgICAgIFsnc3RhcnRzLXdpdGgnLCAnJGtleScsICd2emFhci92ejgvM2EyL3NvdXJjZS92ejgzYTIxNzE1ZjExMDQ4ZDg5YzBhNWNmNTFjMTRiNGRmLyddLAogICAgICAgICAgeydhY2wnOiAncHJpdmF0ZSd9LAogICAgICAgICAgWydlcScsICckc3VjY2Vzc19hY3Rpb25fc3RhdHVzJywgJzIwMSddCiAgICAgICwgWydzdGFydHMtd2l0aCcsICckc3VjY2Vzc19hY3Rpb25fcmVkaXJlY3QnLCAnJ10sIFsnc3RhcnRzLXdpdGgnLCAnJHgtYW16LW1ldGEtdGl0bGUnLCAnJ10sIFsnc3RhcnRzLXdpdGgnLCAnJHgtYW16LW1ldGEtcHJvZmlsZScsICcnXQogICAgICAgIF19CiAgICAgIA==' }
      let(:access_key_id) { 'AKIAI5FUPZCHG3Q2JLDA' }
      let(:title) { '' }
      let(:guid) { 'vz83a21715f11048d89c0a5cf51c14b4df' }
      let(:key) { 'vzaar/vz8/3a2/source/vz83a21715f11048d89c0a5cf51c14b4df/${filename}' }
      let(:bucket) { 'vz1' }

      let(:xml) do
        <<-XML
          <?xml version="1.0" encoding="UTF-8"?>
          <vzaar-api>
            <https>#{https}</https>
            <signature>#{signature}</signature>
            <expirationdate>#{expiration_date}</expirationdate>
            <acl>#{acl}</acl>
            <success_action_redirect>#{success_action_redirect}</success_action_redirect>
            <profile></profile>
            <accesskeyid>#{access_key_id}</accesskeyid>
            <policy>#{policy}</policy>
            <accesskeyid>#{access_key_id}</accesskeyid>
            <title></title>
            <guid>#{guid}</guid>
            <key>#{key}</key>
            <bucket>#{bucket}</bucket>
          </vzaar-api>
        XML
      end

      specify { expect(subject.https).to eq(https) }
      specify { expect(subject.signature).to eq(signature) }
      specify { expect(subject.expiration_date).to eq(expiration_date) }
      specify { expect(subject.acl).to eq(acl) }
      specify { expect(subject.success_action_redirect).to eq(success_action_redirect) }
      specify { expect(subject.profile).to eq(profile) }
      specify { expect(subject.access_key_id).to eq(access_key_id) }
      specify { expect(subject.policy).to eq(policy) }
      specify { expect(subject.title).to eq(title) }
      specify { expect(subject.guid).to eq(guid) }
      specify { expect(subject.key).to eq(key) }
      specify { expect(subject.bucket).to eq(bucket) }
    end
  end
end
