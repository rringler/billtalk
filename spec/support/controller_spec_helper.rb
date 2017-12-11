RSpec.shared_examples 'a json response' do
  let(:content_type) { subject.content_type }

  it "has a Content-Type of 'application/json'" do
    expect(content_type).to eq('application/json')
  end
end
