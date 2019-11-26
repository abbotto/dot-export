# [Dot-Export](dot-export)

[![Build Status](https://travis-ci.org/abbotto/dot-env.svg?branch=master)](https://travis-ci.org/abbotto/dot-env)
[![license](https://img.shields.io/github/license/mashape/apistatus.svg)](LICENSE)

## Overview

### Usage

Safely export environment variables from a file.
  - Will not overwrite previously set variables in the current process unless the `--overwrite` or `-o` flag is passed.
  - If an environemnt file cannot be located the script will check in the `<DOT_EXPORT_PATH>` directory.

        Usage: dot-export -f <FILE_1> -f <FILE_2> -f <FILE_3>...
               dot-export -p <DOT_EXPORT_PATH> -f <FILE>
               dot-export -o -p <DOT_EXPORT_PATH> -f <FILE>

#### Arguments

- `-c, --command`: Pass a command to run in the `dot-export` script (optional)
- `-f, --file`: The location of an environment file (required)
- `-o, --overwrite`: Overwrite previously exported environment variables (optional)
- `-p, --path`: The base path of the environment files that are passed as arguments (optional)

### Under the hood

#### dot [.]

> Execute commands from a file in the current environment. [LINK](https://pubs.opengroup.org/onlinepubs/007904975/utilities/dot.html)

#### export [set -a]

> When this option is on, the export attribute shall be set for each variable to which an assignment is performed. [LINK](https://pubs.opengroup.org/onlinepubs/009695399/utilities/set.html)

#### Basic example

    set -a; . file.env; set +a;

## Configuration

### Environment variables

| variables       | default | description                                                          |
|-----------------|---------|----------------------------------------------------------------------|
| DOT_EXPORT_PATH |  `./`   | The base path of the environment files that are passed as arguments. |

#### Required variables file

These variables must be provided a value in the current process or an error will be thrown.

List the required variable names:

`<DOT_EXPORT_PATH>/require.env`

    ENV_VAR

#### Default variables file

The values for these variables are baked into the application but can be easily overwritten.

List the variable key/value pairs:

`<DOT_EXPORT_PATH>/default.env`

    ENV_VAR=HELLO_WORLD

#### Module variables file

You can export specific environment variables and make them available as an ES6 JavaScript module called `module.env.js`.

`<DOT_EXPORT_PATH>/module.env.js`

    export default {"ENV_VAR": "HELLO_WORLD"}

Specify the module variables that should be exported:

`<DOT_EXPORT_PATH>/module.env`

    ENV_VAR

#### Expected behavior

- Comments are ignored
- Empty lines are ignored

- Empty values become empty strings

      FOO= -> FOO=""

- Escaped characters are preserved when properly wrapped

      var="foo\sbar"
      var="{\'foo\':\'bar\'}"
      var='{\"foo\":\"bar\"}'

- Newlines are preserved when quoted

      var="multi
      line
      string?query=abc123"

      var='multi
      line
      string?query=abc123'

- Single-quotes and double-quotes are preserved when properly wrapped

      var='{"foo":"bar"}' -> var='{"foo":"bar"}'
      var="{'foo':'bar'}" -> var="{'foo':'bar'}"

- Whitespace is trimmed from unquoted values
      
      var=  foobar   -> var=foobar

- Unescaped nested quotes are removed
      
      var='{'foo':'bar'}' -> var={foo:bar}
      var="{"foo":"bar"}" -> var={foo:bar}

- The output from command substitution will become the assigned value

      var="$(echo 'foobar')" -> var="foobar"

### Contributing

The contributing guidelines can be found [here](https://github.com/abbotto/contrib/blob/master/CONTRIBUTING.md).

[Return to top](#dot-export)
