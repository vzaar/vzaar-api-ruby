module VzaarApi
  describe Video::Subtitle do
    def get_subtitle(index)
      VCR.use_cassette('subtitles/paginate') do
        subs = described_class.paginate(video_id, page: 1, per_page: 3)
        subs.first[index-1]
      end
    end

    before do
      setup_auth!
    end

    let(:video_id) { 14370501 }

    let(:subtitle) { get_subtitle 1 }
    let(:subtitle2) { get_subtitle 2 }
    let(:subtitle3) { get_subtitle 3 }

    describe '#initialize' do
      subject { described_class.new attrs }

      let(:attrs) do
        {
          id: 'id',
          title: 'title',
          code: 'code',
          language: 'language',
          created_at: 'created_at',
          updated_at: 'updated_at',
          scope_id: video_id
        }
      end

      specify { expect(subject.id).to eq 'id' }
      specify { expect(subject.title).to eq 'title' }
      specify { expect(subject.code).to eq 'code' }
      specify { expect(subject.language).to eq 'language' }
      specify { expect(subject.created_at).to eq 'created_at' }
      specify { expect(subject.updated_at).to eq 'updated_at' }
      specify { expect(subject.scope_id).to eq video_id }
    end

    describe '#code' do
      context 'when nothing has changed' do
        let(:changed) { [] }
        let(:changed_attributes) { {} }
        let(:changes) { {} }

        specify { expect(subtitle).not_to be_changed }
        specify { expect(subtitle.changed).to match_array changed }
        specify { expect(subtitle.changed_attributes).to eq changed_attributes }
        specify { expect(subtitle.changes).to eq changes }
      end

      context 'when attributes have changed' do
        before do
          subtitle.code = 'pl'
        end

        let(:changed) { [:code] }
        let(:changed_attributes) { { code: 'pl' } }
        let(:changes) { { code: %w(ru pl) } }

        specify { expect(subtitle).to be_changed }
        specify { expect(subtitle.changed).to match_array changed }
        specify { expect(subtitle.changed_attributes).to eq changed_attributes }
        specify { expect(subtitle.changes).to eq changes }
      end
    end

    describe '.create' do
      context 'when we have a file path' do
        let(:attrs) do
          { file: 'spec/support/files/fr.vtt', code: 'de'  }
        end

        context 'and a new subtilte is created' do
          it 'returns the new subtitle' do
            VCR.use_cassette('subtitles/create_from_file_201') do
              sub = described_class.create(video_id, attrs)
              expect(sub.id).to eq 26887
            end
          end
        end
      end

      context 'when we provide a string' do
        let(:attrs) do
          { content: 'WEBVTT\n', code: 'pl'  }
        end

        context 'and a new subtitle is created' do
          it 'returns the new subtitle' do
            VCR.use_cassette('subtitles/create_201') do
              sub = described_class.create(video_id, attrs)
              expect(sub.id).to eq 26888
            end
          end
        end

        context 'and invalid params are provided' do
          let(:attrs) {{ content: 'WEBVTT\n' }}

          it 'raises an error' do
            VCR.use_cassette('subtitles/create_422') do
              expect { described_class.create(video_id, attrs) }
                .to raise_error(Error, 'Invalid parameters: code is missing')
            end
          end
        end
      end
    end

    describe "update" do
      context "when attribute is updated" do
        specify do
          VCR.use_cassette('subtitles/update_200') do
            pager = described_class.paginate(
              video_id, page: 1, per_page: 3
            )
            sub = pager.first.first
            sub.code = "sr"

            expect(sub.save).to be_truthy
            expect(sub.code).to eq("sr")
          end
        end
      end

      context "when attribute cannot be updated" do
        specify do
          VCR.use_cassette('subtitles/update_422') do
            pager = described_class.paginate(
              video_id, page: 1, per_page: 3
            )
            sub = pager.first.first
            sub.code = ""

            msg = "Invalid parameters: Validation failed: "\
                  "Code field cannot be blank, Language not supported"

            expect { sub.save }.to raise_error(VzaarApi::Error, msg)
          end
        end
      end
    end

    describe '#delete' do
      context 'when subtitle is deleted successfully' do
        specify do
          VCR.use_cassette('subtitles/delete_204') do
            expect(subtitle.delete).to be_truthy
          end
        end
      end
    end

    describe '.paginate' do
      it "loads all subtitels from page 1" do
        VCR.use_cassette('subtitles/paginate') do
          pager = described_class.paginate(
            video_id, page: 1, per_page: 3
          )
          expect(pager.first.length).to eq 3
        end
      end

      describe "first" do
        specify do
          VCR.use_cassette('subtitles/paginate_first') do
            pager = described_class.paginate(
              video_id, page: 1, per_page: 1
            )

            expect(pager.first.first.id).to eq(subtitle.id)
          end
        end
      end

      describe "next" do
        specify do
          VCR.use_cassette('subtitles/paginate_next') do
            pager = described_class.paginate(
              video_id, page: 1, per_page: 1
            )

            expect(pager.next.first.id).to eq(subtitle2.id)
          end
        end
      end

      describe "last" do
        specify do
          VCR.use_cassette('subtitles/paginate_last') do
            pager = described_class.paginate(
              video_id, page: 1, per_page: 1
            )

            expect(pager.last.first.id).to eq(subtitle3.id)
          end
        end
      end
    end
  end
end
