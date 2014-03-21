require 'lugg/version'
require 'lugg/runner'

# A tiny command line utility to search through Rails server log files and
# display requests that meet certain criteria.
#
# Lugg takes one or more files as arguments or input on STDIN and redirects
# that content to STDOUT -- but not before applying some filters. Content will
# be parsed as Rails server log files and only the entire log entries matching
# your criteria are displayed.
#
# You supply criteria by passing in command line options. You can see a full
# list of accepted options by running `lugg -h`:
#
#         --and                        Combine previous and next clause with AND instead of OR
#         --get                        Limit to GET requests
#         --post                       Limit to POST requests
#         --put                        Limit to PUT requests
#         --delete                     Limit to DELETE requests
#         --head                       Limit to HEAD requests
#         --patch                      Limit to PATCH requests
#     -c, --controller CONTROLLER      Limit to requests handled by CONTROLLER
#     -a, --action CONTROLLER_ACTION   Limit to requests handled by CONTROLLER_ACTION
#         --json                       Limit to json requests
#         --html                       Limit to html requests
#         --xml                        Limit to xml requests
#         --csv                        Limit to csv requests
#         --pdf                        Limit to pdf requests
#         --js                         Limit to js requests
#     -f, --format FORMAT              Limit to FORMAT requests
#     -s, --status CODE                Limit requests with status code CODE
#         --since TIME                 Limit to requests made after TIME
#         --until TIME                 Limit to requests made before TIME
#     -d, --duration N                 Limit to requests longer than N ms
#     -u, --uri URI                    Limit to requests matching URI
#     -p, --param KEY=VAL              Limit to requests with param KEY => VAL
#
#     -v, --version                    Display version number
#     -h, --help                       Display this message
#
# Note that all conditions are combined with OR, but you can combine two
# conditions with the `--and` flag.
module Lugg
end
