describe Teambition::API do
  include Teambition::API

  before(:example) do
    self.token = TEAMBITION_TOKEN
  end

  it 'checks access token' do
    expect(valid_access_token?).to be_truthy
  end
end
