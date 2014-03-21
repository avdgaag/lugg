# Lugg &mdash; query Rails log files [![Build Status](https://secure.travis-ci.org/avdgaag/lugg.png?branch=master)](http://travis-ci.org/avdgaag/lugg)

A tiny command line utility to search through Rails server log files and display
requests that meet certain criteria.

## Installation

Lugg is distributed as a Ruby gem, which should be installed on most Macs and
Linux systems. Once you have ensured you have a working installation of Ruby
and Ruby gems, install the gem as follows from the command line:

    $ gem install lugg

You can verify the gem has installed correctly by checking its version number:

    $ lugg -v

If this generates an error, something has gone wrong. You should see something
along the lines of `lugg 1.0.0`.

## Usage

Lugg takes one or more files as arguments or input on STDIN and redirects that
content to STDOUT -- but not before applying some filters. Content will be
parsed as Rails server log files and only the entire log entries matching your
criteria are displayed.

You supply criteria by passing in command line options. You can see a full list
of accepted options by running `lugg -h`:

```
    --and                        Combine previous and next clause with AND instead of OR
    --get                        Limit to GET requests
    --post                       Limit to POST requests
    --put                        Limit to PUT requests
    --delete                     Limit to DELETE requests
    --head                       Limit to HEAD requests
    --patch                      Limit to PATCH requests
-c, --controller CONTROLLER      Limit to requests handled by CONTROLLER
-a, --action CONTROLLER_ACTION   Limit to requests handled by CONTROLLER_ACTION
    --json                       Limit to json requests
    --html                       Limit to html requests
    --xml                        Limit to xml requests
    --csv                        Limit to csv requests
    --pdf                        Limit to pdf requests
    --js                         Limit to js requests
-f, --format FORMAT              Limit to FORMAT requests
-s, --status CODE                Limit requests with status code CODE
    --since TIME                 Limit to requests made after TIME
    --until TIME                 Limit to requests made before TIME
-d, --duration N                 Limit to requests longer than N ms
-u, --uri URI                    Limit to requests matching URI
-p, --param KEY=VAL              Limit to requests with param KEY => VAL

-v, --version                    Display version number
-h, --help                       Display this message
```

Note that all conditions are combined with OR, but you can combine two
conditions with the `--and` flag.

### Documentation

See the inline [API docs](http://rubydoc.info/github/avdgaag/lugg/master/frames) for more information.

## Contributing

1. Fork it ( https://github.com/avdgaag/lugg/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

### Issues

Please report any issues, defects or suggestions in the [Github issue
tracker](https://github.com/avdgaag/lugg/issues).

### What has changed?

See the [HISTORY](https://github.com/avdgaag/lugg/blob/master/HISTORY.md) file for a detailed changelog.

### Credits

Created by: Arjan van der Gaag  
URL: [http://arjanvandergaag.nl](http://arjanvandergaag.nl)  
Project homepage: [http://avdgaag.github.io/lugg](http://avdgaag.github.io/lugg)  
Date: march 2014  
License: [MIT-license](https://github.com/avdgaag/lugg/LICENSE) (same as Ruby)
