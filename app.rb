require 'sinatra/base'
require 'sinatra/flash'
require_relative './lib/wordguesser_game.rb'

class WordGuesserApp < Sinatra::Base

  enable :sessions
  register Sinatra::Flash

  before do
    @game = session[:game] || WordGuesserGame.new('')
  end

  after do
    session[:game] = @game
  end

  # These two routes are good examples of Sinatra syntax
  # to help you with the rest of the assignment
  get '/' do
    redirect '/new'
  end

  get '/new' do
    erb :new
  end

  post '/create' do
    # NOTE: don't change next line - it's needed by autograder!
    word = params[:word] || WordGuesserGame.get_random_word
    # NOTE: don't change previous line - it's needed by autograder!

    @game = WordGuesserGame.new(word)
    redirect '/show'
  end

  # Use existing methods in WordGuesserGame to process a guess.
  # If a guess is repeated, set flash[:message] to "You have already used that letter."
  # If a guess is invalid, set flash[:message] to "Invalid guess."
  post '/guess' do
    begin
      #obtine la primera letra de la palabra
      letter = params[:guess].to_s[0]
      #almacena las letras que se han adivinado
      initial_guesses =@game.guesses
      #revisa si la letra ha sido utilizada
      if !@game.guess(letter)

        flash[:message] = "You have already used that letter."
        #revisa si la letra es invalida
      elsif initial_guesses == @game.guesses
        flash[:message] = "Invalid guess."
      end
      #captura el error para una suposicion invalida
    rescue ArgumentError
      flash[:message] = "Invalid guess."
    end
    #redirecciona a la pagina de show
      redirect '/show'
  end

  # Everytime a guess is made, we should eventually end up at this route.
  # Use existing methods in WordGuesserGame to check if player has
  # won, lost, or neither, and take the appropriate action.
  # Notice that the show.erb template expects to use the instance variables
  # wrong_guesses and word_with_guesses from @game.
  get '/show' do
    # Verifica el resultado del juego utilizando @game.check_win_or_lose
    result = @game.check_win_or_lose
    # Evalúa el resultado y realiza acciones en consecuencia
    case result
    when :win
      # Si el resultado es :win, redirige a la ruta '/win'
      redirect '/win'
    when :lose
      # Si el resultado es :lose, redirige a la ruta '/lose'
      redirect '/lose'
    else
      # Si el resultado no es :win ni :lose, muestra la vista 'show'
      erb :show
    end
  end
  get '/win' do
    # Verifica el resultado del juego utilizando @game.check_win_or_lose
    result = @game.check_win_or_lose
    # Redirige a la ruta '/show' si el resultado es :play
    redirect '/show' if result == :play
    # Si el resultado no es :play, muestra la vista 'win'
    erb :win
  end
  get '/lose' do
    # Verifica el resultado del juego utilizando @game.check_win_or_lose
    result = @game.check_win_or_lose
    # Redirige a la ruta '/show' si el resultado es :play
    redirect '/show' if result == :play
    # Si el resultado no es :play, muestra la vista 'lose'
    erb :lose
  end

end
