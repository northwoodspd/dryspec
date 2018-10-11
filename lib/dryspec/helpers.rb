module DRYSpec
  module Helpers
    # This allows us to simplify the case where we want to
    # have a context which contains one or more `let` statements
    #
    # Supports giving either a Hash or a String and a Hash as arguments
    # In both cases the Hash will be used to define `let` statements
    # When a String is specified that becomes the context description
    # If String isn't specified, Hash#inspect becomes the context description
    #
    # @example Defining a simple let variable
    #   # Before
    #   subject { a + 1 }
    #   context('a is 1') do
    #     let(:a) { 1 }
    #     it { should eq 2 }
    #   end
    #
    #   # After
    #   subject { a + 1 }
    #   let_context(a: 1) { it { should eq 2 } }
    #
    # @example Giving a descriptive string
    #   subject { a + 1 }
    #   let_context('Negative number', a: -1) { it { should eq 0 } }
    #
    # @example Multiple variables
    #   subject { a + b }
    #   let_context(a: 1, b: 2) { it { should eq 3 } }
    def let_context(*args, &block)
      context_string, hash =
        case args.map(&:class)
        when [String, Hash] then ["#{args[0]} #{args[1]}", args[1]]
        when [Hash] then [args[0].inspect, args[0]]
        end

      context(context_string) do
        hash.each { |var, value| let(var) { value } }

        instance_eval(&block)
      end
    end

    # Allows you to simply specify that the subject should raise an exception
    # Takes no arguments or arguments of an exception class, a string, or both.
    #
    # As with RSpec's basic `to raise_error` matcher, if you don't give an error
    # then the an unexpected error may cause your test to pass incorrectly
    #
    # @example Raising a string
    #   # Before
    #   subject { fail 'Test' }
    #   it "should raise 'Test'" do
    #     expect { subject }.to raise_error 'Test'
    #   end
    #
    #   # After
    #   subject { fail 'Test' }
    #   subject_should_raise 'Test'
    #
    # @example Raising an exception class
    #   subject { fail ArgumentError }
    #   subject_should_raise ArgumentError
    #
    # @example Raising an exception class and string
    #   subject { fail ArgumentError, 'Test' }
    #   subject_should_raise ArgumentError, 'Test'
    def subject_should_raise(*args)
      error, message = args
      it_string = "subject should raise #{error}"
      it_string += " (#{message.inspect})" if message

      it it_string do
        expect { subject }.to raise_error error, message
      end
    end

    # Allows you to simply specify that the subject should not raise an exception.
    # Takes no arguments or arguments of an exception class, a string, or both.
    #
    # As with RSpec's basic `not_to raise_error` matcher, if you give a specific error, other
    # unexpected errors may be swallowed silently
    #
    # @example Subject does not raise an error
    #   # Before
    #   subject { 1 }
    #   it 'should not raise an exception' do
    #     expect { subject }.not_to raise_error
    #   end
    #
    #   # After
    #   subject { 1 }
    #   subject_should_not_raise
    def subject_should_not_raise(*args)
      error, message = args
      it_string = "subject should not raise #{error}"
      it_string += " (#{message.inspect})" if message

      it it_string do
        expect { subject }.not_to raise_error error, message
      end
    end

    # A shortcut for a combination of `context` and `subject`
    #
    # @example Multiple subjects from let variables
    #
    #   let(:foo) { 55 }
    #   let(:bar) { 66 }
    #
    #   # Before
    #   context 'subject: foo' do
    #     subject { foo }
    #
    #     it { should eq(55) }
    #   end
    #
    #   context 'subject: bar' do
    #     subject { bar }
    #
    #     it { should eq(66) }
    #   end
    #
    #   # After
    #   for_subject(:foo) { it { should eq(55) } }
    #   for_subject(:bar) { it { should eq(66) } }
    def for_subject(variable, &block)
      context "subject: #{variable}" do
        subject { send(variable) }

        instance_eval(&block)
      end
    end
  end
end
