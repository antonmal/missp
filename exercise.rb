class Exercise
  attr_accessor :exercise_array, :words_array
  @@words_num = 1

  def initialize
    get_words
    choose_firsts
  end

  def get_words
    agr = [ { "$sample" => {:size => @@words_num} } ]
    @words_array = $coll.aggregate(agr).to_a
  end

  def choose_firsts
    @exercise_array = []
    @words_array.each do |w|
      @exercise_array.push ({
        word: w[:word],
        misspelling: w[:misspelling],
        show_word_first: [true, false].sample
      })
    end
  end

  # def show_exercise
  #   exercise.each do |e|
  #     if e[:show_first] == :word
  #       puts "#{e[:word]} => #{e[:misspelling]}"
  #       puts " 1 or 2 ?"
  #       answer = gets.strip.to_i
  #       puts answer == 1 ? "Correct" : "Wrong"
  #       puts "-----"
  #     else
  #       puts "#{e[:misspelling]} => #{e[:word]}"
  #       puts " 1 or 2 ?"
  #       answer = gets.strip.to_i
  #       puts answer == 2 ? "Correct" : "Wrong"
  #       puts "-----"
  #     end
  #   end
  # end
end # Exercise
