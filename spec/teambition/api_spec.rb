describe Teambition::API do
  include Teambition::API

  it 'returns authorize url' do
    expect(authorize_url Teambition.callback_url).to be_an_instance_of(String)
  end

  it 'gets access token' do
    expect(get_access_token 'an-invalid-code').to be_nil
  end

  it 'checks access token' do
    expect(check_access_token TEAMBITION_TOKEN).to be_truthy
    expect(check_access_token 'an-invalid-token').to be_falsy
  end
end
