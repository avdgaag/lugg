require 'lugg/request_matcher'

module Lugg
  describe RequestMatcher do
    it 'starts as inactive' do
      expect(subject).not_to be_active
    end

    it 'starts as unfinished' do
      expect(subject).not_to be_finished
    end

    context 'after matching a "Started" line' do
      before do
        subject =~ 'Started'
      end

      it 'becomes active' do
        expect(subject).to be_active
      end

      context 'and then a "Completed" line' do
        before do
          subject =~ 'Completed'
        end

        it 'becomes inactive' do
          expect(subject).not_to be_active
        end

        it 'becomes finished' do
          expect(subject).to be_finished
        end
      end
    end
  end
end
