require 'lugg/streamer'

module Lugg
  describe Streamer do
    let(:fixture) { File.open(File.expand_path('../../fixtures/example.log', __FILE__)) }
    subject       { described_class.new(fixture) }
    it            { should have(555).records }

    it 'returns an enumerator' do
      expect(subject.records).to be_a(Enumerator)
    end

    it 'yields Request objects' do
      request = subject.records.first
      expect(request).to be_a(Request)
    end

    it 'creates Request objects with the full request source' do
      request = subject.records.first
      expect(request.source).to have(6).lines
    end

    context 'using request data' do

    end
  end
end
