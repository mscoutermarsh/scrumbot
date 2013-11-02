shared_examples Encryptable do

  describe '#encryption_key' do
    let(:key) { described_class.new.encryption_key }


    context 'production' do
      before(:each) do
        Rails.env.stub(:production?).and_return(true)
      end

      it 'raises error if not set' do
        ENV['ENCRYPTION_KEY'] = nil
        expect{ key }.to raise_error
      end

      it 'returns ENV variable if set' do
        ENV['ENCRYPTION_KEY'] = 'fake_key'
        expect(key).to eql 'fake_key'
      end
    end

    context 'not production' do
      before(:each) do
        Rails.env.stub(:production?).and_return(false)
      end

      it 'returns ENV variable if set' do
        ENV['ENCRYPTION_KEY'] = 'fake_key'
        expect(key).to eql 'fake_key'
      end

      it 'returns test_key if ENV variable not set' do
        ENV['ENCRYPTION_KEY'] = nil
        expect(key).to eql 'test_key'
      end
    end
  end
end