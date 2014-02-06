$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + '/../lib/')

begin
  require 'debugger'
  require 'debugger-pry'
rescue LoadError
  # The two requires will fail on Ruby 1.8, but we don't particularly care
end
