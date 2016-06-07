describe Teambition::HasTeambitionAccout do
  before(:example) do
    @base = Class.new { include Teambition::HasTeambitionAccout }
  end

  it 'wraps API' do
    obj = Class.new(@base) do
      has_teambition_account namespace: :tb, token: :token
    end.new
    obj.define_singleton_method(:token) { 'my-token' }
    expect(obj.tb.token).to eql(obj.token)
  end

  context 'with nil token' do
    it 'fails' do
      expect do
        Class.new(@base) do
          has_teambition_account token: nil
        end.new
      end.to raise_error(ArgumentError)
    end
  end

  context 'with nil namespace' do
    it 'includes API directly with a token delegation' do
      obj = Class.new(@base) do
        attr_accessor :my_token
        has_teambition_account namespace: nil, token: :my_token
      end.new

      obj.my_token = 'my-token'
      expect(obj.token).to eql('my-token')
    end

    context 'when delegate :token to :token' do
      it 'still works' do
        # This situation equals to `include Teambition::API`

        obj = Class.new(@base) do
          has_teambition_account namespace: nil, token: :token
        end.new

        obj.token = 'my-token'
        expect(obj.token).to eql('my-token')
      end
    end
  end
end
