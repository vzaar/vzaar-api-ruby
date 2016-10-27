module VzaarApi
  class ApiResponse

    attr_reader :response

    def initialize(response)
      @response = response
    end

    def data
      json[:data]
    end

    def meta
      json[:meta]
    end

    def error
      simple_errors.join('; ')
    end

    def ok?
      response.ok?
    end

    private

    def simple_errors
      json[:errors].map { |e| [e[:message], e[:detail]].join(': ') }
    end

    def json
      @json ||= JSON.parse(response.body, symbolize_names: true)
    end

  end
end
