/*
Copyright 2015 Google Inc. All rights reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

// Golden
local bash_golden = std.lines([
  "#!/usr/bin/env bash",
  "if [ $# -lt 1 ] ; then",
  "    echo \"No arguments!\"",
  "else",
  "    echo \"$# arguments!\"",
  "fi",
]);

// Soft tabs
local bash_soft = |||
  #!/usr/bin/env bash
  if [ $# -lt 1 ] ; then
      echo "No arguments!"
  else
      echo "$# arguments!"
  fi
|||;
std.assertEqual(bash_golden, bash_soft) &&

// Hard tabs
local bash_hard = |||
	#!/usr/bin/env bash
	if [ $# -lt 1 ] ; then
	    echo "No arguments!"
	else
	    echo "$# arguments!"
	fi
|||;
std.assertEqual(bash_golden, bash_hard) &&

// Mixed tabs
local bash_mixed = |||
  #!/usr/bin/env bash
  if [ $# -lt 1 ] ; then
      echo "No arguments!"
  else
      echo "$# arguments!"
  fi
|||;
std.assertEqual(bash_golden, bash_mixed) &&


// Chomp trailing newline
local str1 = |||-
  foo bar baz
|||;

std.assertEqual(str1, "foo bar baz") &&


// Chomp just one trailing newline
local str1 = |||-
  foo bar baz

|||;

std.assertEqual(str1, "foo bar baz\n") &&


// Concatenate chomped blocks
local str1 = |||-
    foo bar baz
||| + " " + |||-
    biz buzz
|||;

std.assertEqual(str1, "foo bar baz biz buzz") &&


// More indent
local str1 = |||
        text
    |||;

std.assertEqual(str1, "text\n") &&


// Escape chars
local str1 = |||
        \n
    |||;

std.assertEqual(str1, "\\n\n") &&


// Blank line with trailing whitespace
local blank_line1 = |||
        foo

        bar
    |||;

std.assertEqual(blank_line1, "foo\n\nbar\n") &&


// Blank line no trailing whitespace
local blank_line2 = |||
        foo

        bar
    |||;

std.assertEqual(blank_line2, "foo\n\nbar\n") &&

// Initial blank line
local blank_line3 = |||

        foo
    |||;

std.assertEqual(blank_line3, "\nfoo\n") &&

// Interaction with operators (1)
local op1 = "foo"+|||
  foo
|||;

std.assertEqual(op1, "foofoo\n") &&

// Interaction with operators (2)
local op2 = "foo"<|||
  foo
|||;

std.assertEqual(op2, true) &&

// whitespace after |||
local whitespace_after = |||
  foo
|||;

std.assertEqual(whitespace_after, "foo\n") &&


true