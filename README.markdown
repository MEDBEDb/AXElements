# AXElements

AXElements is a DSL abstraction built on top of the Mac OS X
Accessibility and CGEvent APIs that allows code to be written in a
very natural and declarative style that describes user interactions.

The framework is optimized for writing tests that require automatic
GUI manipulation, whether it be finding controls on the screen,
typing, clicking, or other ways in which a user can interact with the
computer.


## Demo

[Demo Video](http://www.youtube.com/watch?v=G9O5wzb7oTY)

The code from the demo video is right here:

```ruby
    require 'rubygems'
    require 'ax_elements'

    # Highlight objects that the mouse will move to
    Accessibility.debug = true

    # Get a reference to the Finder and bring it to the front
    finder = AX::Application.new 'com.apple.finder'
    set_focus_to finder

    # Open a new window
    type "\\COMMAND+n"
    sleep 1 # pause for "slow motion" effect

    # Find and click the "Applications" item in the sidebar
    window = finder.main_window
    click window.outline.row(static_text: { value: 'Applications' })

    # Find the Utilities folder
    utilities = window.row(text_field: { filename: 'Utilities' })
    scroll_to utilities
    double_click utilities

    # Wait for the folder to open and find the Activity Monitor app
    app = wait_for :text_field, ancestor: window, filename: /Activity Monitor/
    scroll_to app
    click app

    # Bring up QuickLook
    type " "
    sleep 1 # pause for "slow motion"

    # Click the Quick Look button that opens the app
    click finder.quick_look.button(id: 'QLControlOpen')
    sleep 1 # pause for "slow motion"

    # Get a reference to activity monitor and close the app
    activity_monitor = app_with_bundle_identifier 'com.apple.ActivityMonitor'
    terminate activity_monitor

    # Close the Finder window
    select_menu_item finder, 'File', 'Close Window'
```


## Getting Setup

You will need to have Ruby installed to use AXElements. Since AXElements
depends on various OS X frameworks, only Rubies with mature support for
C extensions or bridge support can run AXElements. Supported rubies are:

  - [Ruby 1.9.3+](http://www.ruby-lang.org/)
  - [MacRuby 0.13+](http://macruby.org/) (v0.13 is a nightly build right now)

You will also need to make sure you "enable access for assistive devices".
This can be done in System Preferences in the Universal Access section:

![Universal Access](http://ferrous26.com/images/enable_accessibility.png)

Then you can install AXElements either from RubyGems or from source. The
RubyGems install is as usual, but you may need `sudo` power:

```bash
    gem install AXElements
```

Or you can install from source:

```bash
    cd ~/Documents # or where you want to put the AXElements code
    git clone git://github.com/AXElements/AXElements
    cd AXElements && rake install
```

Once all the setup is finished, you can start up AXElements in IRB:

```bash
    irb -rubygems -rax_elements
```

__NOTE__: If you are not using RVM, but are using MacRuby, then you
should use `macrake` instead of `rake`, and `macirb` instead of `irb`,
etc.. You may also need to add `sudo` to your command when you install
the gem. If you are not using RVM with MacRuby, but have RVM
installed, remember to disable it like so:

```bash
    rvm use system
```


## Getting Started

The [wiki](http://github.com/AXElements/AXElements/wiki)
is the best place to get started, it includes tutorials to help you get
started. API documentation is also available on
[rdoc.info](http://rdoc.info/gems/AXElements/frames).

Though it is not required, you may want to read Apple's
[Accessibility Overview](http://developer.apple.com/library/mac/#documentation/Accessibility/Conceptual/AccessibilityMacOSX/OSXAXModel/OSXAXmodel.html)
as a primer on some the rationale for the accessibility APIs as well
as some of the technical the technical underpinnings of AXElements.


## Development

[![Dependency Status](https://gemnasium.com/AXElements/AXElements.png)](https://gemnasium.com/AXElements/AXElements)
[![Code Climate](https://codeclimate.com/github/AXElements/AXElements.png)](https://codeclimate.com/github/AXElements/AXElements)

AXElements has reached a point where the main focus is stability,
documentation, and additional conveniences. It will be out of this
world, so we're code naming the next version "Lunatone".

![The Moon](https://raw.github.com/AXElements/axelements.github.com/master/images/next_version.png)

Proper releases to rubygems will be made as milestones are reached.

### Road Map

There are still a bunch of things that could be done to improve
AXElements. Some of the higher level tasks are outlined in various
[Github Issues](http://github.com/AXElements/AXElements/issues).
Smaller items are peppered through the code base and marked with `@todo`
tags.


## Test Suite

Before starting development on your machine, you should run the test
suite and make sure things are kosher. The nature of this library
requires that the tests take over your computer while they run. The
tests aren't programmed to do anything destructive, but if you
interfere with them then something could go wrong. To run the tests
you simply need to run the `test` task:

```bash
    rake test
```

If there is a test that crashes MacRuby then you will need to run tests
in verbose mode.

__NOTE__: There may be some tests are dependent on Accessibility
features that are new in OS X Lion which will cause test failures on
OS X Snow Leopard. If you have any issues then you should look at the
output to find hints at what went wrong and/or log a bug. AXElements
will support Snow Leopard for as long as MacRuby does, but I do not
have easy access to a Snow Leopard machine to verify that things still
work.

### Benchmarks

Benchmarks are also included as part of the test suite, but they are
disabled by default. In order to enable them you need to set the
`BENCH` environment variable:

```bash
    BENCH=1 rake test
```


## Contributing to AXElements

See {file:CONTRIBUTING.markdown}


## Copyright

Copyright (c) 2010-2013, Marketcircle Inc.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright
  notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright
  notice, this list of conditions and the following disclaimer in the
  documentation and/or other materials provided with the distribution.
* Neither the name of Marketcircle Inc. nor the names of its
  contributors may be used to endorse or promote products derived
  from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL Marketcircle Inc. BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
