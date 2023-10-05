class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    #descartamos algunas posibilidades
    raise ArgumentError if letter.nil? || letter.empty? || letter =~ /[^a-zA-Z]/
    #convertimos a minuscula
    letter.downcase!
    #comprobamos si la letra esta en la palabra
    if @word.include?(letter)
      #si esta, comprobamos si ya estaba en la lista de aciertos
      return false if @guesses.include?(letter)
      #si no estaba, la añadimos
      @guesses += letter
    #si la letra no esta, comprobamos si ya estaba en la lista de fallos
    else
      #si ya estaba, devolvemos false
      return false if @wrong_guesses.include?(letter)
      #si no estaba, la añadimos
      @wrong_guesses += letter
    end
    #devolvemos
    return true
  end

  def word_with_guesses
    # Inicializamos una variable para almacenar la representación de la palabra
    wordguesses = ''
    # Iteramos a través de cada letra en la palabra original
    @word.each_char do |letter|
      if @guesses.include?(letter)
        # Si la letra actual está en la lista de letras adivinadas (en @guesses)
        # la agregamos a la representación de la palabra
        wordguesses += letter
      else
        # Si la letra actual no está en la lista de letras adivinadas, la reemplazamos con un guion ("-")
        wordguesses += '-'
      end
    end
    # Devolvemos la representación de la palabra con letras adivinadas y guiones
    return wordguesses
  end

  def check_win_or_lose
    # Comprobamos si la palabra con letras adivinadas es igual a la palabra original
    # Si es igual, el jugador ha adivinado todas las letras y ha ganado
    return :win if self.word_with_guesses == @word

    # Comprobamos si el número de fallos es mayor o igual a 7
    # Si el jugador ha realizado 7 o más intentos incorrectos, pierde el juego
    return :lose if @wrong_guesses.length >= 7

    # Si no se cumple ninguna de las condiciones anteriores, el juego todavía está en curso
    # En este caso, devolvemos :play para indicar que el juego sigue en marcha
    return :play
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
