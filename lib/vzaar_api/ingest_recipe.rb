module VzaarApi
  class IngestRecipe

    include Lib::HasResourceUrl
    include Lib::ActiveObject::Find
    include Lib::ActiveObject::Create
    include Lib::ActiveObject::Save
    include Lib::ActiveObject::Delete
    include Lib::WillPaginate

    ENDPOINT = 'ingest_recipes'

    attr_reader :id, :recipe_type, :account_id, :user_id, :created_at, :updated_at
    attr_accessor :name, :description, :default, :multipass, :frame_grab_time,
      :encoding_preset_ids, :generate_animated_thumb, :generate_sprite,
      :use_watermark, :send_to_youtube, :encoding_presets

    def initialize(attrs = {})
      update_from_attributes(attrs)
    end

    def encoding_presets
      @encoding_presets = Array(@encoding_presets)
    end

    def to_hash
      {
        id: self.id,
        name: self.name,
        recipe_type: self.recipe_type,
        description: self.description,
        account_id: self.account_id,
        user_id: self.user_id,
        default: self.default,
        multipass: self.multipass,
        frame_grab_time: self.frame_grab_time,
        generate_animated_thumb: self.generate_animated_thumb,
        generate_sprite: self.generate_sprite,
        use_watermark: self.use_watermark,
        send_to_youtube: self.send_to_youtube,
        encoding_preset_ids: self.encoding_preset_ids,
        created_at: self.created_at,
        updated_at: self.updated_at
      }
    end

    private

    def update_from_attributes(attrs = {})
      @id = attrs[:id]
      @name = attrs[:name]
      @recipe_type = attrs[:recipe_type]
      @description = attrs[:description]
      @account_id = attrs[:account_id]
      @user_id = attrs[:user_id]
      @default = attrs[:default]
      @multipass = attrs[:multipass]
      @frame_grab_time = attrs[:frame_grab_time]
      @generate_animated_thumb = attrs[:generate_animated_thumb]
      @generate_sprite = attrs[:generate_sprite]
      @use_watermark = attrs[:use_watermark]
      @send_to_youtube = attrs[:send_to_youtube]
      @encoding_presets = EncodingPreset.build(attrs[:encoding_presets])
      @encoding_preset_ids = @encoding_presets.map(&:id)
      @created_at = attrs[:created_at]
      @updated_at = attrs[:updated_at]
    end

  end
end
