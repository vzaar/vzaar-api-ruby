require 'spec_helper'

module Vzaar
  describe ProcessVideo do

    subject { described_class.new xml }

    let(:video_id) { '1407672' }

    let(:xml) do
      <<-XML
        <?xml version="1.0" encoding="UTF-8"?>
        <vzaar-api>
          <video>#{video_id}</video>
        </vzaar-api>
      XML
    end

    specify { expect(subject.video_id).to eq(video_id) }

  end
end
