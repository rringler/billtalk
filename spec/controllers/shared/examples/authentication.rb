RSpec.shared_examples 'an authenticated endpoint', shared_context: :metadata do
  before do
    described_class.send(:define_method, :authenticate_user) {}
  end

  it 'requires client authentication' do
    expect_any_instance_of(described_class).to receive(:authenticate_user)
    subject
  end
end

RSpec.shared_examples 'an unauthenticated endpoint', shared_context: :metadata do
  before do
    described_class.send(:define_method, :authenticate_user) {}
  end

  it 'does not require client authentication' do
    expect_any_instance_of(described_class).to_not receive(:authenticate_user)
    subject
  end
end

RSpec.configure do |rspec|
  # Note: It's kind of hacky that RSpec does not provide #include_examples
  rspec.include_context 'an authenticated endpoint',   authenticated: true
  rspec.include_context 'an unauthenticated endpoint', authenticated: false
end
