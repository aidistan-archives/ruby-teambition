require 'spec_helper'

describe Teambition do
  it 'has client key' do
    expect(Teambition.respond_to? :client_key).to be true
  end

  it 'has client secret' do
    expect(Teambition.respond_to? :client_secret).to be true
  end

  it 'has callback url' do
    expect(Teambition.respond_to? :callback_url).to be true
  end
end
