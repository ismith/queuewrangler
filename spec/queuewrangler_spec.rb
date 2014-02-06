require 'spec_helper'
require 'queuewrangler'

describe QueueWrangler::Wrangler do
  class DeferredAction
    include QueueWrangler::Wrangler
    def initialize
      initialize_queuewrangler(true)
    end
  end

  context 'instance methods' do
    subject(:wrangler) { DeferredAction.new }

    it { should respond_to :run! }
    it { should respond_to :dead? }

    it { should respond_to :die! }
    describe '#die!' do
      it 'should process the queue' do
        wrangler.should_receive(:process_queue)
        wrangler.die!
      end
    end

    it { should respond_to :process_queue }
    it { should respond_to :enqueue}

    describe '#enqueue' do
      let(:uuid) { rand }
      let(:event) { 'rspec_wrangler' }

      it 'should enqueue a proper message' do
        wrangler.enqueue(:foo, uuid, event, :extra_info => 'bogus')
        expect(wrangler.queue.size).to eql(1)
      end
    end

    describe '#process_queue' do
      let(:uuid) { rand }
      let(:event) { 'rspec_wrangler' }

      it 'should call class method with correct parameters' do
        wrangler.enqueue(:foo, uuid, event, :extra_info => 'bogus')
        wrangler.should_receive(:foo).with(uuid, event, :extra_info => 'bogus').and_return(true)
        wrangler.process_queue
      end
    end
  end
end
