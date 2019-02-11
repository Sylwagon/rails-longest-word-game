require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('A'..'Z').to_a[rand(26)] }
  end

  def score
    attempt = params[:word]
    grid = params[:letters]
  # j'ouvre l'URL pour tester le mot propose
  # Je lis les donnees de l'URL avec le mot propose
  check_attempt = open("https://wagon-dictionary.herokuapp.com/#{attempt}").read
  # je prend la donnee de resultat pour le mot propose
  existing_word = JSON.parse(check_attempt)
  # Je regarde le resultat avec la cle found pour le mot propose
  # je creer une matrice des lettre du mot propose
  # Je verifie que pour chaque lettre du mot propose, j'ai bien une lettre qui correspond de grid
  # J'initialise une variable qui me dit que le test est bon
  letters_in_grid = true
  attempt.upcase.chars.each { |x| letters_in_grid = false if grid.count(x) < attempt.upcase.chars.count(x) }
  # je teste pour chaque lettre si le nombre d'occurence de la lettre est >= au nombre de la lettres de grid
  # si le test est negatif, je passe la variable result_test a 0
  # je definis un hash pour afficher le resultat
  m_s = { message: "", score: 0 }
  # je calcule le temps ecoule entre debut et fin
  # elapsed_time = end_time - start_time
  # j'ecris not in grid si le test letters in grid est negatif
  m_s[:message] = "/not in the grid/" unless letters_in_grid
  # j'ecris not an english word si le test extisting word est negatif
  m_s[:message] = "/not an english word/" unless existing_word['found']
  # j'ecrs Well done si les 2 tests sont positifs
  m_s[:message] = "/Well done/" if letters_in_grid && existing_word['found']
  # je calcule le score en fonction des resultat des tests
  @m_s = m_s[:message]
  end
end
