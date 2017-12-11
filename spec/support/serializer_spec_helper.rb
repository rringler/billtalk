module SerializerSpecHelper
  def serialize(object)
    serializer = described_class.new(object)

    ActiveModelSerializers::Adapter.create(serializer).to_json
  end
end

RSpec.configure do |rspec|
  rspec.include SerializerSpecHelper, type: :serializer
end
