require 'lugg/filter'
require 'lugg/request'

module Lugg
  describe Filter do
    let(:records) { [Request.new('example')] }

    it 'matches all records by default' do
      expect(subject.call(records)).to eql(records)
    end

    it 'allows adding matchers to filter records' do
      subject.use { |record| false }
      expect(subject.call(records)).to be_empty
    end

    it 'combines matchers using OR' do
      subject.use { |record| false }
      subject.use { |record| true }
      expect(subject.call(records)).to eql(records)
    end

    it 'allows adding lambdas as matchers' do
      subject.use ->(record) { false }
      expect(subject.call(records)).to be_empty
    end

    it 'disallows using both a block and a callable' do
      expect { subject.use ->(record) { false } { true } }.to raise_error(ArgumentError)
    end

    it 'disallows callables that are not callable' do
      expect { subject.use 'foo' }.to raise_error(ArgumentError)
    end
  end
end
