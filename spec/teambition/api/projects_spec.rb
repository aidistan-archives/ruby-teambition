describe Teambition::API do
  include Teambition::API

  before(:example) do
    self.token = TEAMBITION_TOKEN
    @me = get '/api/users/me'
  end

  it 'gets projects' do
    res = get '/api/projects'
    expect(res).to be_an_instance_of(Array)
    if res.count > 0
      expect(res.first['_id']).to be_an_instance_of(String)
      res = get '/api/projects/' + res.first['_id']
      expect(res).to be_an_instance_of(Hash)
    end
  end

  xit 'creates & deletes projects' do
    res = post '/api/projects',
      name: 'ruby-teambition',
      description: 'Temp project created by ruby-teambition'
    expect(res).to be_an_instance_of(Hash)
    expect(res['_creatorId']).to eql(@me['_id'])

    # Why not have a rest?
    sleep(0.5)

    res = delete '/api/projects/' + res['_id']
    expect(res).to be_an_instance_of(Hash)
    expect(res.empty?).to be_truthy
  end
end
