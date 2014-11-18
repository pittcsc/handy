require 'test_helper'

class DictionaryTest < ActiveSupport::TestCase
  test 'maintains a list of words' do
    File.stubs(:readlines).with(Dictionary::WORDS_FILE_PATH).returns(%w(grape thing))

    assert_equal %w(grape thing), Dictionary.words
  end

  test 'samples random words' do
    File.stubs(:readlines).with(Dictionary::WORDS_FILE_PATH).returns(%w(grape thing))

    assert_includes [%w(grape), %w(thing)], Dictionary.sample(1)
    assert_includes [%w(grape thing), %w(thing grape)], Dictionary.sample(2)
  end
end
