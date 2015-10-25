class Dictionary
  include Singleton

  WORDS_FILE_PATH = Rails.root.join('share', 'dictionary.txt')

  def words
    @words ||= File.readlines(WORDS_FILE_PATH).each(&:strip!)
  end

  def reload
    @words = nil
  end

  def sample(count = 1)
    words.sample(count)
  end
end
