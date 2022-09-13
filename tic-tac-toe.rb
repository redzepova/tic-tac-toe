###Set up players###

class Player
    @@total_score = 0
    attr_accessor :name, :current, :piece, :selection, :score

    def initialize(string)
        puts "What's your name, #{string}?"
        @name = gets.chomp
        @current = false
        @selection = []
        puts "Select your game piece, #{@name}"
        @piece = gets.chomp
        puts "OK, #{@name}, your game piece is #{@piece}"
        @score = 0
    end

    def add_selection(number)
        @selection << number
    end

    def make_play(game)
        puts "Make your move, #{@name} - pick a square"
        selection = gets.chomp.to_i
        if game.squares[selection-1].played == true
            puts "That square has already been played"
        else
            game.squares[selection-1].display = "[  #{@piece}  ]"
            game.squares[selection-1].played = true
            add_selection(selection)
            @current = false
            display_board(game)
            game.determine_winner(@selection)
            if game.winner == true
                @score += 1
            end
        end
    end
end

class Player1 < Player
    def initialize(n)
        super
        @current = true
    end
end

class Player2 < Player
end

####Make Game board####

class GameBoard
    attr_accessor :name, :squares, :winner, :winning_moves

    

    def initialize(n)
        self.name = name
        @squares = []
        @winner = false
        @winning_moves = [[1,2,3],[4,5,6], [7,8,9], [1,4,7],[2,5,8],[3,6,9], [1,5,9], [3,5,7]]
    end

    def add_square(square)
        @squares << square
        square.name = self
    end

    def determine_winner(array)
        if array.length > 2
            x = 0
            while x < array.length - 2
                new_array = array.sort.slice(x, 3)
                @winning_moves.each do |element|
                    if new_array == element
                        @winner = true
                        puts "Tic Tac Toe - Three-in-a-Row!"
                    end
                end
                x += 1
            end
        end
    end
                
end

class Squares
    attr_accessor :name, :display, :played

    @@all = []

    def initialize(name)
        self.name = name
        @display = "[  #{name}  ]"
        @@all << self
        self.played = false
    end
end

### Set up game ###

def create_game_board(game)
    x = 1
    
    while x < 10
        name = "#{x}"
        square = Squares.new(name)
        game.add_square(square)
        x += 1
    end
end

def display_board(game)
    x = 0
    y = 0
    z = 0

    while x < 3
        while y < 3
            print game.squares[z].display
            z += 1
            y += 1
        end
        puts ""
        y = 0
        x += 1
    end
end

def play_game(game, player1, player2)
    x = 0
    while game.winner == false && x < 9
        if player1.current == true
            player1.make_play(game)
            player1.current = false
        else
            player2.make_play(game)
            player1.current = true
        end
    x += 1
    end
    if game.winner == false && x == 9
        puts "Tic-tac-TIE"
    end
end

####Game Play###

puts "TIC - TAC - TOE"
puts "Let's play!"

player1 = Player1.new("Player 1")
player2 = Player2.new("Player 2")

new_game = "Y"

def game_setup(player1, player2, game_num, game_name)
    puts "#{player1.name}'s score: #{player1.score}"
    puts "#{player2.name}'s score: #{player2.score}"
    game_num = GameBoard.new(game_name)
    create_game_board(game_num)
    display_board(game_num)
    play_game(game_num, player1, player2)
end

while new_game == "Y"
    x = 1
    game_name = "Game #{x}"
    game_num = "game#{x}"
    game_setup(player1, player2, game_num, game_name)
    puts "Play again? Y/N"
    new_game = gets.chomp.upcase
    player1.selection = []
    player2.selection = []
    x += 1
end


#game1 = GameBoard.new("Game 1")

#create_game_board(game1)#
#display_board(game1)



#play_game(game1, player1, player2)
