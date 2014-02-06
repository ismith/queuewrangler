require 'logger'

module QueueWrangler
  module Wrangler
    attr_reader :queue

    #  Initializes the queue and performs other prepatory work required before
    #  queue processing may begin.
    #
    #  @param [Boolean] enabled True if the queue should be processed
    #  @param [Logger] logger Where to log or no logging if not specified
    def initialize_queuewrangler(enabled, logger=nil)
      @enabled = enabled
      @queue = Queue.new
      @should_die = false
      @logger = logger || Logger.new(nil)
    end

    def log
      @logger
    end

    # Determine whether the runloop is dead or not
    def dead?
      @should_die
    end

    # Instruct the runloop to die and flush our internal queue of events
    def die!
      @should_die = true
      process_queue
    end

    # Flush the outstanding events in the events queue
    def process_queue
      until @queue.empty?
        method, args = @queue.pop

        unless method.nil?
          log.info("process_queue - handling #{method} with #{args.inspect}")
          if @enabled
            processed = send(method, *args)

            unless processed
              log.info "Failed to process #{method}"
              enqueue(method, *args)
              # Arbitrary sleep to make sure we don't spin when we cannot
              # process a message infinitly
              sleep 1
            end
          end
        end
      end
    end

    def run!
      id = self.class.name.split('::').last
      log.info "#{id}#runloop - starting the runloop, processing: #{@enabled}"
      until dead?
        process_queue
        # Arbitrary sleep just to make sure we don't spin on
        # #process_queue when the queue is completely empty
        sleep 0.5
      end
      log.info "#{id}#runloop - ending the runloop"
    end

    def enqueue(method, *args)
      @queue << [method, [*args]]
    end
  end
end
