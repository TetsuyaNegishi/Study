Price = 1000
CoinNum = 15

# pattern = 0

# for i10 in 0..15 do
#   for i50 in 0..(15 - i10) do
#     for i100 in 0..(15 - i10 - i50) do
#       for i500 in 0..(15 - i10 - i50 - i100) do
#         pattern += 1 if 10 * i10 + 50 * i50 + 100 * i100 + 500 * i500 == 1000
#       end
#     end
#   end
# end

# p pattern

# 別解

coins = [10, 50, 100, 500]
pattern = 0
(2..CoinNum).each do |i|
  coins.repeated_combination(i).each{|coin_set|
    pattern += 1 if coin_set.inject(:+) == 1000
  }
end

p pattern
