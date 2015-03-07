# Handy

Handy takes attendance at events via SMS.

[![Travis CI][travis_badge]][travis]


## Getting Started

If you need to build your environment from the ground up, read contributing.md. Else, read on.

Install the system services Handy relies on:

* MySQL 5.6
* [wkhtmltopdf][wkhtmltopdf]

Clone the Handy repository and run `bin/provision/setup`:

```bash
git clone git@github.com:Pitt-CSC/handy.git
cd handy
bin/setup
```

That's it!


[travis_badge]: https://travis-ci.org/Pitt-CSC/handy.svg?branch=master
[travis]: https://travis-ci.org/Pitt-CSC/handy
[wkhtmltopdf]: http://wkhtmltopdf.org/
