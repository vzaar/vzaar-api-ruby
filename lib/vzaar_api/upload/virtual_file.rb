module VzaarApi
  module Upload
    class VirtualFile < StringIO

      attr_reader :path

      def initialize(file, chunk_size)
        @path = File.basename file.path
        super file.read(chunk_size)
      end

    end
  end
end
