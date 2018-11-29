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
        expect(subject.x_amz_headers)
          .to eq("x-amz-credential" => "credential",
                 "x-amz-algorithm" => "AWS4-HMAC-SHA256",
                 "x-amz-date" => "date",
                 "x-amz-signature" => "signature")
      end
    end
  end
end
