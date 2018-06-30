N = 100

cards = Array.new(N, false)

for n in 2..N do
  i = n
  while i <= N
    cards[i - 1] = !cards[i - 1]
    i += n
  end
end

for n in 1..N do
  p n if !cards[n - 1]
end