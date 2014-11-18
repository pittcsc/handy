require 'test_helper'

class DictionaryTest < ActiveSupport::TestCase
  setup do
    File.stubs(:readlines).with(Dictionary::WORDS_FILE_PATH).returns(%w(grape thing))
  end

  test 'maintains a list of words' do
    assert_equal %w(grape thing), Dictionary.words
  end

  test 'samples one random word' do
    assert_includes [%w(grape), %w(thing)], Dictionary.sample
  end

  test 'samples many random words' do
    assert_includes [%w(grape thing), %w(thing grape)], Dictionary.sample(2)
  end
end
