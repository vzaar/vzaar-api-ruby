require_relative './../spec_helper'

module VzaarApi
  describe 'Ingest recipe: Create / Update / Delete' do

    let(:described_class) { IngestRecipe }
    let(:id) { api_envs['ingest_recipe']['default'] }
    let(:other_id) { api_envs['ingest_recipe']['other'] }

    context 'when user is authenticated' do
      before { setup_for :account_owner }

      let(:attrs) do
        {
          name: 'new SDK recipe',
          description: 'created by the SDK tests',
          default: true,
          frame_grab_time: 5.5,
          multipass: false,
          generate_animated_thumb: true,
          generate_sprite: true,
          use_watermark: true,
          send_to_youtube: true,
          encoding_preset_ids: [2, 3, 4]
        }
      end

      it 'creates, updates and deletes a resource' do
        # create new recipe
        recipe = described_class.create attrs
        expect(recipe.name).to eq 'new SDK recipe'
        expect(recipe.default).to eq true
        expect(recipe.encoding_presets.map(&:id)).to match_array [2, 3, 4]

        # ensure previous default has changed
        expect(described_class.find(id).default).to eq false

        # perform update
        name = "updated at: #{Time.now.utc}"
        recipe.name = name
        recipe.encoding_preset_ids = [4, 5, 6]
        recipe.save
        expect(recipe.name).to eq name
        expect(recipe.encoding_presets.map(&:id)).to match_array [4, 5, 6]

        # ensure you cannot unset current default
        recipe.default = false
        expect { recipe.save }.to raise_error(
          Error, 'Invalid parameters: You cannot unflag your default ingest recipe')

        # restore previous default
        default = described_class.find(id)
        expect(recipe.default).to eq false
        default.default = true
        default.save
        expect(default.default).to eq true

        # reload original recipe
        recipe = described_class.find(recipe.id)
        expect(recipe.default).to eq false

        # delete recipe
        recipe.delete
        expect{ described_class.find(recipe.id) }.to raise_error(
            Error, 'Not found: Resource cannot be found')
      end
    end

  end
end
