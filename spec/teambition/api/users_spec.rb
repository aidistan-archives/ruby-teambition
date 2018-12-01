describe Teambition::API do
  include Teambition::API

  before(:example) do
    self.token = TEAMBITION_TOKEN
  end

  it 'gets user info' do
    res = get '/api/users/me'
    expect(res).to be_an_instance_of(Hash)
    expect(res['_id']).to be_an_instance_of(String)
    expect(res['email']).to match(/\w+@\w+/)
  end

  it 'gets the count of today\'s tasks' do
    res = get '/api/users/todayCount'
    expect(res).to be_an_instance_of(Hash)
    expect(res['todayCount']).to be >= 0
  end
end
