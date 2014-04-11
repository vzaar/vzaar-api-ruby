module Vzaar
  class SignatureExtractor < Struct.new(:data, :format)
    include Vzaar::Helper

    def extract
      _format == :xml ? from_xml : data
    end

    private

    def _format
      blank?(format) ? :xml : format.to_sym
    end

    def from_xml
      { https: xml_extractor('//vzaar-api/https'),
        signature: xml_extractor('//vzaar-api/signature'),
        expiration_date: xml_extractor('//vzaar-api/expirationdate'),
        acl: xml_extractor('//vzaar-api/acl'),
        success_action_redirect: xml_extractor('//vzaar-api/success_action_redirect'),
        profile: xml_extractor('//vzaar-api/profile'),
        access_key_id: xml_extractor('//vzaar-api/accesskeyid'),
        aws_access_key: xml_extractor('//vzaar-api/accesskeyid'),
        policy: xml_extractor('//vzaar-api/policy'),
        title: xml_extractor('//vzaar-api/title'),
        guid: xml_extractor('//vzaar-api/guid'),
        key: xml_extractor('//vzaar-api/key'),
        bucket: xml_extractor('//vzaar-api/bucket')
      }
    end

    def xml_extractor(xpath)
      return '' if xml_data.to_s == ''
      xml_data.at_xpath(xpath) ? xml_data.at_xpath(xpath).text : ''
    end

    def xml_data
      @xml_data ||= Nokogiri::XML(data)
    end
  end
end
