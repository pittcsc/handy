class Dictionary
  WORDS_FILE_PATH = Rails.root.join('share', 'dictionary.txt')

  class << self
    def words
      @words ||= File.readlines(WORDS_FILE_PATH).each(&:strip!)
    end

    def sample(count)
      words.sample(count)
    end
  end
end
