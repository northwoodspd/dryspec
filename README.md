# DRYSpec

DRYSpec introduces the `let_context`, `subject_should_raise`, and `subject_should_not_raise` helpers into RSpec which can allow you to have shorter, easier to read spec files.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dryspec'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dryspec

Then add `config.extend DRYSpec::Helpers` to your RSpec configuration like so:

    require 'dryspec'

    RSpec.configure do |config|
      # ... configuration ...

      config.extend DRYSpec::Helpers

      # ... configuration ...

## Usage

### `let_context`

The `let_context` helper allows you to easily create a `context` block with one or more `let` variables like so:

    # Before
    context 'The foo is 1' do
      let(:foo) { 1 }
    end

    # After
    let_context foo: 1 do
    end

In some cases, this case even allow you to have one line per example.  For example, let's say you were testing an `#add_two` method.  You could do:

    subject { add_two(value) }

    let_context(value: 10) { it { should eq 12 } }
    let_context(value: 1) { it { should eq 3 } }
    let_context(value: 0) { it { should eq 2 } }

By default when you give `let_context` a `Hash`, the `#inspect` of the `Hash` becomes the description for your example which you see in your test output.  If you'd like something more specific you can add a string like so:

    let_context('Negative number', value: -1) { it { should eq 1 } }
    let_context('Big negative number', value: -10) { it { should eq -8 } }

### `subject_should_(not_)raise`

The `subject_should_raise` and `subject_should_not_raise` are simply helpers which allow you to create an RSpec example which asserts if the subject of your tests will raise an exception.  For example:

    # Before
    subject { fail 'Test' }
    it "should raise 'Test'" do
      expect { subject }.to raise_error 'Test'
    end

    # After
    subject { fail 'Test' }
    subject_should_raise 'Test'

There is also a `subject_should_not_raise`:

    subject { 1 }
    subject_should_not_raise

## Documentation

See [the documentation](TODO) for more details

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/northwoodspd/dryspec. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

