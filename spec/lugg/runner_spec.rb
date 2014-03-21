require 'stringio'
require 'lugg/runner'

module Lugg
  describe Runner do
    before        { $stdout = stdout }
    after         { $stdout = STDOUT }
    let(:stdout)  { StringIO.new }
    let(:options) { [] }
    subject       { described_class.new(options) }

    context 'without any options' do
      let(:input) { "Started\nCompleted\n" }

      it 'outputs requests from input without conditions' do
        subject.run(StringIO.new(input))
        expect(stdout.string).to eql("Started\nCompleted\n")
      end
    end

    context 'with --get' do
      let(:options) { ['--get'] }
      let(:input)   { "Started GET\nCompleted 1\nStarted POST\nCompleted 2\n" }

      it 'limits requests to GET requests' do
        subject.run(StringIO.new(input))
        expect(stdout.string).to eql("Started GET\nCompleted 1\n")
      end
    end

    context 'with --post --and --controller PostsController' do
      let(:options) { %w(--post --and --controller PostsController) }
      let(:input)   { "Started GET\nProcessing by PostsController#index as HTML\nCompleted 1\nStarted POST\nProcessing by BlogController#create as HTML\nCompleted 2\n" }

      it 'limits requests to GET requests' do
        subject.run(StringIO.new(input))
        expect(stdout.string).to eql("Started POST\nProcessing by BlogController#create as HTML\nCompleted 2\n")
      end
    end

    context 'with --controller PostsController' do
      let(:options) { %w(--controller PostsController) }
      let(:input)   { "Started GET\nProcessing by PostsController#index as HTML\nCompleted 1\nStarted POST\nProcessing by BlogController#create as HTML\nCompleted 2\n" }

      it 'limits requests to GET requests' do
        subject.run(StringIO.new(input))
        expect(stdout.string).to eql("Started GET\nProcessing by PostsController#index as HTML\nCompleted 1\n")
      end
    end

    context 'with --since 2012-03-20' do
      let(:options) { %w(--since 2012-03-20) }
      let(:input)   { "Started GET at 2012-03-21 12:00 +0100\nCompleted 1\nStarted GET at 2012-03-19\nProcessing by BlogController#create as HTML\nCompleted 2\n" }

      it 'limits requests to GET requests' do
        subject.run(StringIO.new(input))
        expect(stdout.string).to eql("Started GET at 2012-03-21 12:00 +0100\nCompleted 1\n")
      end
    end

    context 'with --param foo=bar' do
      let(:options) { ['--param', 'foo=val'] }
      let(:input)   { "Started GET\n  Parameters: {\"foo\"=>\"val\"}\nCompleted 1\nStarted POST\nProcessing by BlogController#create as HTML\nCompleted 2\n" }

      it 'limits requests to GET requests' do
        subject.run(StringIO.new(input))
        expect(stdout.string).to eql("Started GET\n  Parameters: {\"foo\"=>\"val\"}\nCompleted 1\n")
      end
    end
  end
end
