require 'spec_helper'

module DRYSpec
  RSpec.describe Helpers do
    describe 'let_context' do
      subject { a + b }
      describe 'one variable' do
        let(:b) { 1 }

        let_context(a: 2) { it { should eq 3 } }

        let_context('Negative number', a: -1) { it { should eq 0 } }
      end
      let_context(a: 1, b: 2) { it { should eq 3 } }
    end

    describe 'subject_should_raise' do
      describe 'Raising string' do
        subject { fail 'Test' }

        subject_should_raise 'Test'
      end

      describe 'Raising exception class' do
        subject { fail ArgumentError }

        subject_should_raise ArgumentError
      end

      describe 'Raising exception class and string' do
        subject { fail ArgumentError, 'Test' }

        subject_should_raise ArgumentError, 'Test'
      end
    end

    describe 'subject_should_not_raise' do
      subject { 1 }

      subject_should_not_raise
    end

    describe 'for_subject' do
      let(:foo) { 55 }
      let(:bar) { 66 }

      for_subject(:foo) { it { should eq(55) } }
      for_subject(:bar) { it { should eq(66) } }
    end
  end
end
