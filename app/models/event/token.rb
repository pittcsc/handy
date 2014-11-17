class Event::Token
  DICTIONARY_FILE_PATH = Rails.root.join('share', 'dictionary.txt')

  class << self
    def generate(words)
      dictionary.sample(words).join(' ')
    end

    private
      def dictionary
        @dictionary ||= File.readlines(DICTIONARY_FILE_PATH).each(&:strip!)
      end
  end
end
