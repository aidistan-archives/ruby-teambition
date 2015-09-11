describe Teambition::API do
  include Teambition::API

  it 'return authorize url' do
    expect(authorize_url Teambition.callback_url).to be_an_instance_of(String)
  end

  it 'get access token' do
    expect(get_access_token 'this-is-a-fake-code').to be_nil
  end
end
