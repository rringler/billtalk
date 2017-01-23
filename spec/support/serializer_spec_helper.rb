module SerializerSpecHelper
  def serialize(object, options = {})
    serializer_klass = options.delete(:serializer) || "#{object.class.name}Serializer".constantize
    serializer       = serializer_klass.send(:new, object)
    adapter_klass    = ActiveModelSerializers::Adapter
    adapter          = adapter_klass.create(serializer, options)

    adapter.to_json
  end
end
