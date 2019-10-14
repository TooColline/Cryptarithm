# frozen_string_literal: true

# This class in an example of the cryparithmic solution
class Example
  include Enumerable
  # Instantiate global empty arrays and range
  @@global_range = Array(100..999)
  @@bbg = []
  @@fun = []
  @@stn = []

#   def self.calcpossiblestns
#     @@calcpossiblestns
#   end

  def listoffunpossibilities
    # FUN values should meet the criteria below:
    # 1. 3 digit value
    # 2. All are unique
    @@global_range.each do |i|
      @@fun.push(i) unless /([0-9]).*?\1/.match?(i.to_s)
    end
    @@fun
  end

  def listofbbgpossibilities
    # BBG values should meet the criteria below:
    # 1. 3 digit value
    # 2. First 2 digits are similar
    @@global_range.each do |i|
      digits = i.to_s.split(//).map(&:to_i)
      @@bbg.push(i) if digits[0] == digits[1] && digits[1] != digits[2]
    end
    @@bbg
  end

  def checkifsolutionsconformtopattern(solution, funvalue)
    # Function ensures that the final solution conforms to the rules below:
    # 1. 6 digit value
    # 2. The third and the fourth digit are similar
    # 3. No other digits are similar
    # 4. Second digit is similar to the second digit of the FUN value
    # 5. First digit of solution should not be similar to first digit(F) of FUN
    solution_digits = solution.to_s.split(//).map(&:to_i)
    fundigits = funvalue.to_s.split(//).map(&:to_i)

    if solution_digits.length == 6 &&
       solution_digits[1] == fundigits[1] &&
       solution_digits[0] != fundigits[0] &&
       solution_digits[2] != fundigits[2] &&
       solution_digits[2] == solution_digits[3] &&
       solution_digits[0] != solution_digits[1] &&
       solution_digits[0] != solution_digits[2] &&
       solution_digits[0] != solution_digits[4] &&
       solution_digits[0] != solution_digits[5] &&
       solution_digits[1] != solution_digits[2] &&
       solution_digits[1] != solution_digits[4] &&
       solution_digits[1] != solution_digits[5] &&
       solution_digits[2] != solution_digits[4] &&
       solution_digits[2] != solution_digits[5] &&
       solution_digits[4] != solution_digits[5]
      return !@@stn.include?(solution)
    end
  end

  def calcpossiblestns
    funvaluelist = listoffunpossibilities
    bbgvaluelist = listofbbgpossibilities
    funvaluelist.each do |funvalue|
      bbgvaluelist.each do |bbgvalue|
        solution = funvalue * bbgvalue
        if checkifsolutionsconformtopattern(solution, funvalue)
          puts "#{funvalue} * #{bbgvalue} = #{solution}"
          @@stn.push(solution)
        end
      end
    end
    puts "There are #{@@stn.length} unique solutions"
  end
end

a = Example.new
a.calcpossiblestns
