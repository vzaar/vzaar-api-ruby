require "date"

module SharedExamples
  shared_examples "includes x-amz headers hash" do
    specify do
      expect(subject.x_amz_headers)
        .to eq("x-amz-credential" => "abc",
               "x-amz-algorithm" => "alg",
               "x-amz-date" => "date",
               "x-amz-signature" => "sig")
    end
  end

  shared_examples "assigns x-amz headers from response" do |cassette_name|
    specify do
      VCR.use_cassette(cassette_name) do
        expect(subject.x_amz_headers["x-amz-credential"]).to eql(
          "AKIAJ74MFWNVAFH6P7FQ/#{Date.today.strftime("%Y%m%d")}/us-east-1/s3/aws4_request"
        )
        expect(subject.x_amz_headers["x-amz-algorithm"]).to eql "AWS4-HMAC-SHA256"
        expect(subject.x_amz_headers["x-amz-signature"].length).to eql 64
        expect(subject.x_amz_headers["x-amz-date"][0..7]).to eql Date.today.strftime("%Y%m%d")
      end
    end
  end
end
