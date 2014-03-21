require 'lugg/request'

module Lugg
  describe Request do
    subject { described_class.new('test') }

    it 'considers two objects with the same source equal' do
      other = Request.new('test')
      expect(subject).to eql(other)
      expect(subject == other).to be_true
    end

    it 'can not modify the contents of the source' do
      expect { subject.source.downcase! }.not_to change { subject.source }
    end

    context 'for an actual request' do
      let(:fixture) { File.open(File.expand_path('../../fixtures/example.log', __FILE__)).each_line.first(6).join("\n") }
      subject { described_class.new(fixture) }

      its(:method)     { should eql('GET') }
      its(:path)       { should eql('/offenses/search') }
      its(:uri)        { should eql('/offenses/search?q=r315twe&_=1385727839720') }
      its(:query)      { should eql('q=r315twe&_=1385727839720') }
      its(:ip)         { should eql('212.78.221.106') }
      its(:timestamp)  { should eql(Time.new(2013, 11, 29, 13, 24, 16, '+01:00')) }
      its(:controller) { should eql('OffensesController') }
      its(:action)     { should eql('OffensesController#search') }
      its(:status)     { should eql('OK') }
      its(:code)       { should eql(200) }
      its(:duration)   { should eql(37) }
      its(:params)     { should eql('q' => 'r315twe', '_' => '1385727839720') }
      its(:format)     { should eql('JSON') }
    end
  end
end
