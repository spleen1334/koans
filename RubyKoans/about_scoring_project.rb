require File.expand_path(File.dirname(__FILE__) + '/neo')

# Greed is a dice game where you roll up to five dice to accumulate
# points.  The following "score" function will be used to calculate the
# score of a single roll of the dice.
#
# A greed roll is scored as follows:
#
# * A set of three ones is 1000 points
#
# * A set of three numbers (other than ones) is worth 100 times the
#   number. (e.g. three fives is 500 points).
#
# * A one (that is not part of a set of three) is worth 100 points.
#
# * A five (that is not part of a set of three) is worth 50 points.
#
# * Everything else is worth 0 points.
#
#
# Examples:
#
# score([1,1,1,5,1]) => 1150 points
# score([2,3,4,6,2]) => 0 points
# score([3,4,5,3,3]) => 350 points
# score([1,5,1,2,4]) => 250 points
#
# More scoring examples are given in the tests below:
#
# Your goal is to write the score method.

def score(dice)
  # You need to write this method
  #
  # MOJE SUGAVO RESENJE
  # result = 0
  # counter = 0
  #
  # result if dice.empty?
  #
  # dice.map do|num|
  #   case num
  #   when 5
  #     result += 50
  #   when 1
  #     result += 100
  #     counter += 1
  #   end
  # end
  #
  #   if counter >= 3 then
  #     result -= 300
  #     result += 1000
  #   end
  #
  # def triple(array)
  #   x = 0
  #   b = []
  #   array.sort.each do |num|
  #     b << num if x === num && num != 1
  #     x = num
  #   end
  #   if !b.empty? && b.count > 1
  #     b.first === 5 ? (b.first * 100) - 150 : b.first * 100
  #   else
  #     0
  #   end
  # end
  #
  # result + triple(dice)


  # MNOGO PROSTIJE RESENJE:
  # result  = 0
  # counter = Hash.new(0)
  #
  # Koristan deo jednog resenja:
  # 1. Ubacuje sve elemente u []
  # 2. To dovodi do toga da ukoliko vec postoji counter[1]
  #    da se povecava njegov value za 1
  #    >> counter[1] = 2
  # 3. Pravi se novi loop:
  #    counter.each do |index, val|
  # 4. unutar petlje ide: case index
  # 5. prave se when za:
  #    when 1, when 5 i else
  # 6. val se koristi da bi se dobilo koliko ima istih brojeva
  # 7. Nakon toga ide sabiranje
  #
  # dice.each do |x|
  #   counter[x] +=1
  # end
  #
  # counter.each do |x,y|
  #   case x
  #     when 1
  #       if y>3
  #         result+=1000
  #         y-=3
  #       else
  #         y.times { result+=100 }
  #       end
  #
  #     when 5
  #       if y>3
  #         result+=500
  #         y-=3
  #         y.times { result+=50 }
  #       end
  #
  #     else
  #       if y>3
  #         result+= x*100
  #       end
  #   end
  # end


  # RUBY LEPSE RESENJE:
  # -------------------
  score = 0

  # upto() = Integer method
  1.upto(6).each do |num|
    amount = dice.count(num) # count() > broji koliko ima el u [] navedenih kao parametar
    if amount >= 3
      score += num == 1 ? 1000 : num * 100
      amount -= 3 # brise amount, da bi donje sabiranje moglo da radi za pojedinacne 1, 5
    end

    score += 100 * amount if num == 1
    score += 50 * amount if num == 5
  end

  score
end

class AboutScoringProject < Neo::Koan
  def test_score_of_an_empty_list_is_zero
    assert_equal 0, score([])
  end

  def test_score_of_a_single_roll_of_5_is_50
    assert_equal 50, score([5])
  end

  def test_score_of_a_single_roll_of_1_is_100
    assert_equal 100, score([1])
  end

  def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
    assert_equal 300, score([1,5,5,1])
  end

  def test_score_of_single_2s_3s_4s_and_6s_are_zero
    assert_equal 0, score([2,3,4,6])
  end

  def test_score_of_a_triple_1_is_1000
    assert_equal 1000, score([1,1,1])
  end

  def test_score_of_other_triples_is_100x
    assert_equal 200, score([2,2,2])
    assert_equal 300, score([3,3,3])
    assert_equal 400, score([4,4,4])
    assert_equal 500, score([5,5,5])
    assert_equal 600, score([6,6,6])
  end

  def test_score_of_mixed_is_sum
    assert_equal 250, score([2,5,2,2,3])
    assert_equal 550, score([5,5,5,5])
    assert_equal 1100, score([1,1,1,1])
    assert_equal 1200, score([1,1,1,1,1])
    assert_equal 1150, score([1,1,1,5,1])
  end

end
