describe Teambition::API do
  include Teambition::API

  before(:example) do
    self.token = TEAMBITION_TOKEN
  end

  it 'validates the token' do
    expect(valid_token?).to be_truthy
  end
end
