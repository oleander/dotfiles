## Code Example Extractor for Rust Crate Documentation

### Instructions:

- Input: Documentation copied from a web page for a Rust crate.
- The input includes non-relevant data due to the copy-paste method.
- Compress examples to maintain the same meaning but with less code.
- Keep the order of code examples as they appear in the input.
- The goal is to extract code examples for later use as context when asking questions about the crate.
- Important:
  1. Do not fabricate code. Only use code from the user input.
  2. Ensure relevant parts are not removed, making the code incomplete.
  3. Include:
     - Required features for a snippet to be valid.
     - All relevant `use` statements related to the example.
- Exclude boilerplate code not relevant to the crate, such as general installation comments.
- Exclude comments and use short titles for the code instead.
- If output size needs to be limited, append a list of snippets that were not included at the bottom.

- Please exclude:
  1. General comments on how to install the crate, but keep the ones providing useful info the user, like in the example output below
  2. Non-relevant boilerplate code

### Example Input:

```
Specifying argument types
There are three types of arguments that can be supplied to each (sub-)command:
	•	short (e.g. -h),
	•	long (e.g. --help)
	•	and positional.
Like clap, structopt defaults to creating positional arguments.
If you want to generate a long argument you can specify either long = $NAME, or just long to get a long flag generated using the field name. The generated casing style can be modified using the rename_all attribute. See the rename_all example for more.
For short arguments, short will use the first letter of the field name by default, but just like the long option it’s also possible to use a custom letter through short = $LETTER.
If an argument is renamed using name = $NAME any following call to short or long will use the new name.
Attention: If these arguments are used without an explicit name the resulting flag is going to be renamed using kebab-case if the rename_all attribute was not specified previously. The same is true for subcommands with implicit naming through the related data structure.
use structopt::StructOpt;

#[derive(StructOpt)]
#[structopt(rename_all = "kebab-case")]
struct Opt {
    /// This option can be specified with something like `--foo-option
    /// value` or `--foo-option=value`
    #[structopt(long)]
    foo_option: String,

    /// This option can be specified with something like `-b value` (but
    /// not `--bar-option value`).
    #[structopt(short)]
    bar_option: String,

    /// This option can be specified either `--baz value` or `-z value`.
    #[structopt(short = "z", long = "baz")]
    baz_option: String,

    /// This option can be specified either by `--custom value` or
    /// `-c value`.
    #[structopt(name = "custom", long, short)]
    custom_option: String,

    /// This option is positional, meaning it is the first unadorned string
    /// you provide (multiple others could follow).
    my_positional: String,

    /// This option is skipped and will be filled with the default value
    /// for its type (in this case 0).
    #[structopt(skip)]
    skipped: u32,
}

Flattening
It can sometimes be useful to group related arguments in a substruct, while keeping the command-line interface flat. In these cases you can mark a field as flatten and give it another type that derives StructOpt:
#[derive(StructOpt)]
struct Cmdline {
    /// switch on verbosity
    #[structopt(short)]
    verbose: bool,
    #[structopt(flatten)]
    daemon_opts: DaemonOpts,
}

#[derive(StructOpt)]
struct DaemonOpts {
    /// daemon user
    #[structopt(short)]
    user: String,
    /// daemon group
    #[structopt(short)]
    group: String,
}
In this example, the derived Cmdline parser will support the options -v, -u and -g.
This feature also makes it possible to define a StructOpt struct in a library, parse the corresponding arguments in the main argument parser, and pass off this struct to a handler provided by that library.
Custom string parsers
If the field type does not have a FromStr implementation, or you would like to provide a custom parsing scheme other than FromStr, you may provide a custom string parser using parse(...) like this:
use std::num::ParseIntError;
use std::path::PathBuf;

fn parse_hex(src: &str) -> Result<u32, ParseIntError> {
    u32::from_str_radix(src, 16)
}

#[derive(StructOpt)]
struct HexReader {
    #[structopt(short, parse(try_from_str = parse_hex))]
    number: u32,
    #[structopt(short, parse(from_os_str))]
    output: PathBuf,
}
There are five kinds of custom parsers:

Environment variable fallback
It is possible to specify an environment variable fallback option for an arguments so that its value is taken from the specified environment variable if not given through the command-line:


#[derive(StructOpt)]
struct Foo {
    #[structopt(short, long, env = "PARAMETER_VALUE")]
    parameter_value: String,
}
By default, values from the environment are shown in the help output (i.e. when invoking --help):
```

### Example Output:

structopt

```rust
use structopt::StructOpt;

#[derive(StructOpt)]
struct Opt { ... }
```

### Specifying argument types

```rust
// <opt> --age 12 --title James
struct Opt {
  #[structopt(short = "p", long)]
  age: u32, // --age <value> OR -p <value>

  #[structopt(name = "title", short)]
  name: String, // -t value

  #[structopt(skip)]
  skipped: u32, // Defaults to 0
}
```

### Flatten (`flatten`)

> Lifts the arguments into the parent structure from one below

```rust
// <main> -u Linus -g Admin
struct Main {
  #[structopt(flatten)]
  sub: Sub,
}

struct Sub {
  #[structopt(short)]
  user: String,

  #[structopt(short)]
  group: String,
}
```

### Others

1. Custom string parsers: `--hex 3E9` for `hex: u32`
2. Environment variable fallback: `PIN=123` same as `--pin 123`


USER INPUT:

