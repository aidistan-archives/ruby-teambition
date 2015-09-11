require 'spec_helper'

describe Teambition do
  it 'has DOMAINs' do
    expect(Teambition::AUTH_DOMAIN).to be_an_instance_of(String)
    expect(Teambition::API_DOMAIN).to be_an_instance_of(String)
  end

  it 'has client key' do
    expect(Teambition.respond_to? :client_key).to be true
  end

  it 'has client secret' do
    expect(Teambition.respond_to? :client_secret).to be true
  end

  it 'has callback url' do
    expect(Teambition.respond_to? :callback_url).to be true
  end

  it 'returns authorize url' do
    expect(Teambition.authorize_url).to be_an_instance_of(String)
  end

  it 'gets access token' do
    expect(Teambition.get_access_token 'an-invalid-code').to be_nil
  end

  it 'checks access token' do
    expect(Teambition.check_access_token TEAMBITION_TOKEN).to be_truthy
    expect(Teambition.check_access_token 'an-invalid-token').to be_falsy
  end
end
