# frozen_string_literal: true

# handle Ctrl-C (SIGINT) and broken-pipe errors gracefully in CLI scripts

require_relative 'cli-pasta/sigint'
require_relative 'cli-pasta/sigpipe'
