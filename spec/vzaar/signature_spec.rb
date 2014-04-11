require 'spec_helper'

module Vzaar
  describe SignatureExtractor do

    subject { described_class.new(xml, format) }

    let(:format) { :xml }

    context "when xml is returned" do
      let(:https) { 'false' }
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

      describe "#extract" do
        before { @res = subject.extract }

        specify { expect(@res[:https]).to eq(https) }
        specify { expect(@res[:signature]).to eq(signature) }
        specify { expect(@res[:expiration_date]).to eq(expiration_date) }
        specify { expect(@res[:acl]).to eq(acl) }
        specify { expect(@res[:success_action_redirect]).to eq(success_action_redirect) }
        specify { expect(@res[:profile]).to eq(profile) }
        specify { expect(@res[:access_key_id]).to eq(access_key_id) }
        specify { expect(@res[:aws_access_key]).to eq(access_key_id) }
        specify { expect(@res[:policy]).to eq(policy) }
        specify { expect(@res[:title]).to eq(title) }
        specify { expect(@res[:guid]).to eq(guid) }
        specify { expect(@res[:key]).to eq(key) }
        specify { expect(@res[:bucket]).to eq(bucket) }
      end
    end
  end
end
