require 'spec_helper'

module Vzaar::Response
  describe Signature do

    subject { described_class.new xml }

    context "when xml is returned" do
      let(:https) { 'false' }
      let(:signature) { '7BOi7ogK5EEacIwHX56NTUSFCVk=' }
      let(:expirationdate) { '2013-11-22T19:53:12.000Z' }
      let(:acl) { 'private' }
      let(:success_action_redirect) { 'example.com?guid=vz83a21715f11048d89c0a5cf51c14b4df' }
      let(:profile) { '' }
      let(:policy) { 'ewogICAgICAgICdleHBpcmF0aW9uJzogJzIwMTMtMTEtMjJUMTk6NTM6MTIuMDAwWicsCiAgICAgICAgJ2NvbmRpdGlvbnMnOiBbCiAgICAgICAgICB7J2J1Y2tldCc6ICd2ejEnfSwKICAgICAgICAgIFsnc3RhcnRzLXdpdGgnLCAnJGtleScsICd2emFhci92ejgvM2EyL3NvdXJjZS92ejgzYTIxNzE1ZjExMDQ4ZDg5YzBhNWNmNTFjMTRiNGRmLyddLAogICAgICAgICAgeydhY2wnOiAncHJpdmF0ZSd9LAogICAgICAgICAgWydlcScsICckc3VjY2Vzc19hY3Rpb25fc3RhdHVzJywgJzIwMSddCiAgICAgICwgWydzdGFydHMtd2l0aCcsICckc3VjY2Vzc19hY3Rpb25fcmVkaXJlY3QnLCAnJ10sIFsnc3RhcnRzLXdpdGgnLCAnJHgtYW16LW1ldGEtdGl0bGUnLCAnJ10sIFsnc3RhcnRzLXdpdGgnLCAnJHgtYW16LW1ldGEtcHJvZmlsZScsICcnXQogICAgICAgIF19CiAgICAgIA==' }
      let(:accesskeyid) { 'AKIAI5FUPZCHG3Q2JLDA' }
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
            <expirationdate>#{expirationdate}</expirationdate>
            <acl>#{acl}</acl>
            <success_action_redirect>#{success_action_redirect}</success_action_redirect>
            <profile></profile>
            <accesskeyid>#{accesskeyid}</accesskeyid>
            <policy>#{policy}</policy>
            <accesskeyid>#{accesskeyid}</accesskeyid>
            <title></title>
            <guid>#{guid}</guid>
            <key>#{key}</key>
            <bucket>#{bucket}</bucket>
          </vzaar-api>
        XML
      end

      its(:https) { should eq(https) }
      its(:signature) { should eq(signature) }
      its(:expirationdate) { should eq(expirationdate) }
      its(:expiration_date) { should eq(expirationdate) }
      its(:acl) { should eq(acl) }
      its(:success_action_redirect) { should eq(success_action_redirect) }
      its(:profile) { should eq(profile) }
      its(:accesskeyid) { should eq(accesskeyid) }
      its(:aws_access_key) { should eq(accesskeyid) }
      its(:policy) { should eq(policy) }
      its(:title) { should eq(title) }
      its(:guid) { should eq(guid) }
      its(:key) { should eq(key) }
      its(:bucket) { should eq(bucket) }
    end

    context "when xml is nil" do
      let(:xml) { nil }

      its(:https) { should be_empty }
      its(:signature) { should be_empty }
      its(:expirationdate) { should be_empty }
      its(:expiration_date) { should be_empty }
      its(:acl) { should be_empty }
      its(:success_action_redirect) { should be_empty }
      its(:profile) { should be_empty }
      its(:accesskeyid) { should be_empty }
      its(:aws_access_key) { should be_empty }
      its(:policy) { should be_empty }
      its(:title) { should be_empty }
      its(:guid) { should be_empty }
      its(:key) { should be_empty }
      its(:bucket) { should be_empty }
    end

  end
end
