# cli-pasta

[![Build Status](https://github.com/chocolateboy/cli-pasta/workflows/test/badge.svg)](https://github.com/chocolateboy/cli-pasta/actions?query=workflow%3Atest)
[![Gem Version](https://img.shields.io/gem/v/cli-pasta.svg)](https://rubygems.org/gems/cli-pasta)

<!-- TOC -->

- [NAME](#name)
- [INSTALL](#install)
- [SYNOPSIS](#synopsis)
- [DESCRIPTION](#description)
  - [BACKGROUND](#background)
- [COMPATIBILITY](#compatibility)
- [VERSION](#version)
- [SEE ALSO](#see-also)
- [AUTHOR](#author)
- [COPYRIGHT AND LICENSE](#copyright-and-license)

<!-- TOC END -->

# NAME

cli-pasta - handle Ctrl-C and broken-pipe errors gracefully in Ruby command-line tools

# INSTALL

```ruby
gem "cli-pasta"
```

# SYNOPSIS

```ruby
#!/usr/bin/env ruby

require "cli-pasta"
require "optparse"

# ...

ARGF.each do |line|
  puts process(line)
end
```

# DESCRIPTION

cli-pasta packages boilerplate code which is commonly copied 'n' pasted into
Ruby CLI scripts to perform the following tasks:

- set up a `SIGINT` handler to handle <kbd>Ctrl-C</kbd> in the same way as other CLI tools
- set up a `SIGPIPE` handler to handle broken pipes in the same way as other CLI tools

These tasks are executed by loading the corresponding files, either separately, e.g.:

```ruby
require "cli-pasta/sigint"
require "cli-pasta/sigpipe"
```

Or as a group:

```ruby
require "cli-pasta"
```

## BACKGROUND

By default, ruby produces an ugly error message when scripts are interrupted by
<kbd>Ctrl-C</kbd> (`SIGINT`), e.g.:

    $ timeout --signal INT 1 ruby -e sleep

Output:

    Traceback (most recent call last):
            1: from -e:1:in `<main>'
    -e:1:in `sleep': Interrupt

The same is true if a process encounters an error when trying to write to a
broken pipe (`EPIPE`), e.g.:

    $ ruby -e 'loop { puts "." }' | head -n0

Output:

    Traceback (most recent call last):
            5: from -e:1:in `<main>'
            4: from -e:1:in `loop'
            3: from -e:1:in `block in <main>'
            2: from -e:1:in `puts'
            1: from -e:1:in `puts'
    -e:1:in `write': Broken pipe @ io_writev - <STDOUT> (Errno::EPIPE)

The snippets provided by this gem install signal handlers which handle these
errors in the same way as other CLI tools, e.g.:

    $ timeout --signal INT 1 ruby -r cli-pasta -e sleep
    # No output

    $ ruby -r cli-pasta -e 'loop { puts "." }' | head -n0
    # No output

# COMPATIBILITY

- [Maintained ruby versions](https://www.ruby-lang.org/en/downloads/branches/)

# VERSION

2.0.1

# SEE ALSO

* [nice-sigint](https://github.com/xiongchiamiov/nice-sigint) - make Ruby handle SIGINTs in a less-ugly manner

# AUTHOR

[chocolateboy](mailto:chocolate@cpan.org)

# COPYRIGHT AND LICENSE

Copyright © 2018-2021 by chocolateboy.

This is free software; you can redistribute it and/or modify it under the terms
of the [MIT license](https://opensource.org/licenses/MIT).
