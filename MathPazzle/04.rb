N, M = gets.chomp.split(" ").map(&:to_i)

def cutbar(m, n, current)
  p current
  if current >= n then
    0
  elsif current < m then
    1 + cutbar(m, n, current * 2)
  else
    # 1 + cutbar(m, n, current + m)
    ((n - current) / m.to_f ).ceil # 高速化
  end
end

p cutbar(M, N, 1)