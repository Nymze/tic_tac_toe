require 'pry'

# ========================== Joueur ==============================


class Player

# Accede aux variable "name" et "marker" (marker étant la X ou le O)
 attr_accessor :name, :marker

 def initialize(name, marker) # la variable name refere aux input du joueur 1 et joueur 2 (ligne : 74, 75)
     @name = name    # prend la valeur de l'input (en ligne 75 76)
     @marker = marker    
 end
 
 def turn(position=+1)  # à chaque tour le marqueur prend une position
   print "#{name}, choose a position to place your marker: " # on demande quelle position le joueur veut placer sa croix ou rond
   position = gets.chomp.to_i                                # on prend la valeur de la position (sur la grille en fonciton du numero)
   while Board.checkConflict(position)                        # si la position inclue deja un X ou un O alors il y a "conflit" reference ligne : 60 - fonction checkconflict
     print "#{name}, that position is taken, choose another: " # dans le cas ou la position est deja prise on demande de choisir une nouvelle position, on relance la boucle
   position = gets.chomp.to_i 
   end
   Board.update(position,@marker)                            # on mets à jour la grille avec la position du markeur 
 end
end



# ========================= Planche / Format de la grille ========================

class Board                                                 
 @@position = [0,1,2,3,4,5,6,7,8]           # la grille est definie avec plusieurs position de 0 à 8 (on créé un array de 0 à 8)

 def self.update(position,marker)          # la position en fonction du choix du joueur est defini par la variable marker
   @@position[position] = marker
 end

 def self.display                           # on affiche la grille dans la console avec les valeur attitrés à chaque position
   puts "---------------"
   puts "#{@@position[0]} #{@@position[1]} #{@@position[2]}"
   puts "#{@@position[3]} #{@@position[4]} #{@@position[5]}"
   puts "#{@@position[6]} #{@@position[7]} #{@@position[8]}"
   puts "---------------"
 end 

 @@winner = false                            # de base personne n'est "gagnant" donc la valeur winner = false 
                                            # si dessous les conditions de victoire : 
 def self.winner
   case # si la position 0 = position 1 et position 1 = position 2, cela veut dire par example (en prenant la croix) que 0 = X , 1 = X ; 2 = X ce qui donne X X X sur la grille donc victoire.
   when @@position[0] == @@position[1] && @@position[1]== @@position [2] then @@winner = true  
   when @@position[3] == @@position[4] && @@position[4]== @@position [5] then @@winner = true
   when @@position[6] == @@position[7] && @@position[7]== @@position [8] then @@winner = true
   when @@position[0] == @@position[3] && @@position[3]== @@position [6] then @@winner = true
   when @@position[1] == @@position[4] && @@position[4]== @@position [7] then @@winner = true
   when @@position[2] == @@position[5] && @@position[5]== @@position [8] then @@winner = true
   when @@position[0] == @@position[4] && @@position[4]== @@position [8] then @@winner = true
   when @@position[2] == @@position[4] && @@position[4]== @@position [6] then @@winner = true 
   end
   return @@winner
 end

 def self.checkConflict(position)             # cette methode permet de checker les conflict de position, si un marqueur (X or O) est deja présent à une position, ca renvoit à la fonction turn et à la (ligne 20)
  ["x","o"].include? @@position[position]
 end

end

def begining_of_the_game

# Quand le jeu s'initialize on demande le nom du joueur 1
puts "player one 1 choose a Nickname"
name1 = gets.chomp
# # on demande le nom du joueur 2
puts "Player 2 Choose a Nickname"
name2 = gets.chomp

player1 = Player.new(name1,"x") #nom 1 refere à l'input du joueur 1
player2 = Player.new(name2,"o") #nom 2 refere à l'input du joueur 2 

Board.display # on affiche la grille


# créé une boucle pour initier le jeu : tant que la variable "winner = false" on initie le player1.turn donc on initie la méthode "turn" (ligne 15) au joueur 1 (player1)
while Board.winner == false                                       
  player1.turn                                
  Board.display
  puts "#{player1.name} you are the winner!!!" if Board.winner # cette ligne : dans le cas ou toutes les conditions de la méthode self.winner sont remplit on initie la class Board winner (qui prend la valeur true) ce qui donne la victoire du joueur en question
  next if Board.winner == true
  player2.turn                                                    
  Board.display
  puts "#{player2.name} you are the winner!!!" if Board.winner


end 


end

begining_of_the_game

  
  




