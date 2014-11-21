module Vzaar
  module Request
    class ProcessAudio < ProcessVideo
      endpoint '/api/audios'

      private

      def get_opts
        raise Vzaar::Error, "Guid required to process video." unless options[:guid]
        h = options.dup.delete_if { |k,v| v.nil? }
        { vzaar_api: { audio: h }}
      end
    end
  end
end
