module VzaarApi
  class IngestRecipe < Abstract

    ENDPOINT = 'ingest_recipes'

    ATTR_READERS = [:id, :recipe_type, :account_id, :user_id,
                    :created_at, :updated_at].freeze

    ATTR_ACCESSORS = [:name, :description, :default, :multipass,
                      :frame_grab_time, :encoding_preset_ids,
                      :generate_animated_thumb, :generate_sprite,
                      :use_watermark, :send_to_youtube,
                      :encoding_presets].freeze

    prepend Lib::HasAttributes
    include Lib::HasResourceUrl
    include Lib::ActiveObject::Find
    include Lib::ActiveObject::Create
    include Lib::ActiveObject::Save
    include Lib::ActiveObject::Delete
    include Lib::WillPaginate

    def initialize(attrs = {})
      update_from_attributes(attrs)
    end

    private

    def update_from_attributes(attrs = {})
      @encoding_presets = EncodingPreset.build(attrs[:encoding_presets])
      @encoding_preset_ids = @encoding_presets.map(&:id)
    end

  end
end
