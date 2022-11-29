# Brief

Write a ruby script that :-
- Receives a log as argument (webserver.log is provided) e.g. `./parser.rb webserver.log`
- Returns the following :-
    - list of webpages with most page views ordered from most pages views to less page views e.g.:
        ```
        /home 90 visits
        /index 80 visits
        ...
        ```
    - list of webpages with most unique page views also ordered e.g.
        ```
        /about/2 8 unique views
        /index 5 unique views
        ...
        ```

# Solution

## Pre-requisites

- Ruby v3.1.0 or above is installed.
- This repository has been cloned and `bundle install` has been run.

## Usage

### Help
```
$ ./log_parser -h

Command:
  log_parser

Usage:
  log_parser FILE_PATH

Description:
  Command line tool for processing page view logs.

  Page view logs must be in the format :-
    [page_view] [ip_address]

  For example :-
    /home 184.123.665.067
    /about/2 444.701.448.104
    etc

Arguments:
  FILE_PATH                         # REQUIRED Path to log file

Options:
  --aggregator=VALUE, -t VALUE      # Aggregator: (page_views/unique_page_views), default: "page_views"
  --help, -h                        # Print this help
```
### Examples
The followig examples assume that `jq` has been installed.

For analysing logs to work out total page views (also the default when no `--aggregator` option is supplied), run the following :-
```
$ ./log_parser --aggregator=page_views webserver.log | jq

{
  "page_views": {
    "/about/2": 90,
    "/contact": 89,
    "/index": 82,
    "/about": 81,
    "/help_page/1": 80,
    "/home": 78
  }
}
```

For analysing logs to work out total unique page views, run the following :-
```
$ ./log_parser --aggregator=unique_page_views webserver.log | jq
{
  "unique_page_views": {
    "/help_page/1": 23,
    "/contact": 23,
    "/home": 23,
    "/index": 23,
    "/about/2": 22,
    "/about": 21
  }
}
```

Any logs entries that cannot be parsed will send errors to stderr :-
```
$ ./log_parser spec/support/fixtures/badly_formatted.log | jq
Log 'help_page/1' is in incorrect format
Log '/home   184.123.665.067' is in incorrect format
Log '/help_page 184.123.665.067' is in incorrect format
Log '/about 444.701.448' is in incorrect format
Log '/help_page/1' is in incorrect format
Log '/about 444.701.448.104' is in incorrect format
Log '722.247.931.582' is in incorrect format
{
  "page_views": {
    "/about": 1
  }
}
```

If there are no logs to parse at all, the resulting JSON will be empty :-
```
$ ./log_parser spec/support/fixtures/empty.log | jq
{
  "page_views": {}
}
```

If there are isues reading the log file the script will return a non-zero status code and display a useful error :-
```
$ ./log_parser foo/bar.log
Unable to read file - No such file or directory @ rb_sysopen - foo/bar.log
```

## Approach summary

- I made an early design decision to output the solution in JSON because it's both human and machine readable, and start with the `page_views` output format.
- Once I got the barebones `dry_cli` interface ironed out I started by creating some overarching integration tests that call the solution directly via the command line, with hard-coded JSON in the output.
- It became clear fairly early on that there were 3 parts to the solutiom - a source, an aggregator (renamed to that from processor during develpoment) and a presenter.
- I made my way backwards from introducing a presenter (then aggregator, then source), which processed and outputted the same JSON I had hard-coded at the start, I test-drove these parts as I went.
- Once these parts were all playing nicely together, I then introduced the `unique_page_views` output format, which led me to create a couple of factories to fetch the necessary Aggregator and Presenter for either the `page_views` or `unique_page_views` variance supplied in the interface.
- There was plenty of refactoring and DRY-ing up (where appropiate) along the way, with commits made at each point after checking the tests and linting.

## Areas for improvement
- Performance-wise, building large arrays and passing them around in memory perhaps isn't great. I think if performance was of real concern doing the aggregation in some kind of datastore would be sensible.
- The `LogParser#call` entrypoint method has hard-coded dependencies in it, this could be moved out to a separate class to have them injected, but for now I decided that was a level of indirection not warranted at this stage.
- `dry_cli` allows for registering of separate commands as separate classes, it could be refactored to use that style should the overall interface get more complex.
- Some duplication in `Presenter::PageViews` and `Presenter::UniquePageViews`, they could be re-worked to perhaps inherit from a `Presenter` class, although I wasn't sure that was necessarily a better abstraction at this stage.
