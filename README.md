# Queuewrangler

A gem to simplify queueing long running actions for processing in a background
thread.

## Installation

Add this line to your application's Gemfile:

    gem 'queuewrangler'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install queuewrangler

## Usage
``` ruby
require 'queuewrangler'

module RemoteLogger
  class Logger
    include Singleton
    include QueueWrangler::Wrangler

    def initialize
      initialize_queuewrangler(true)
    end

    def log(msg)
      enqueue(:send_data, msg)
    end

    def send_data(msg)
       # perform long running action here
    end
  end
end

Thread.new do
  RemoteLogger::Logger.instance.run!
end

RemoteLogger::Logger.instance.log('This will get enqueued and then sent to the send_data method')

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
