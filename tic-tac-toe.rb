class Player
    @@total_score = 0
    attr_accessor :name, :score, :played, :win, :piece, :selection

    def initialize(n)
        @name = n
        @score = 0
        self.played = false
        self.win = false
        @selection = []
        puts "Select your game piece, #{@name}"
        @piece = gets.chomp
        puts "OK, #{@name}, your game piece is #{@piece}"
    end

    def make_play(game, selection, player_piece)
        if game.squares[selection-1].played == true
            puts "That square has already been played"
        else
            game.squares[selection-1].display = "[  #{player_piece}  ]"
            game.squares[selection-1].played = false
        end
    end 

end

class GameBoard
    attr_accessor :name, :squares

    def initialize(n)
        self.name = name
        @squares = []
    end

    def add_square(square)
        @squares << square
        square.name = self
    end
end

class Squares
    attr_accessor :name, :game_board, :display, :played

    @@all = []

    def initialize(name)
        self.name = name
        @display = "[  #{name}  ]"
        @@all << self
        self.played = false
    end
end

game1 = GameBoard.new("Game 1")

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

create_game_board(game1)
display_board(game1)

def get_player(player)
    puts "what's your name, #{player}?"
    name = gets.chomp
    return Player.new(name)
end

player1 = get_player("Player 1")
player2 = get_player("player 2")

player1.make_play(game1,1, player1.piece)

display_board(game1)



winning_selection = [[1,2,3],[4,5,6], [7,8,9], [1,4,7],[2,5,8],[3,6,9], [1,5,9], [3,5,7]]







