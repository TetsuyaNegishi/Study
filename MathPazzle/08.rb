N = gets.chomp.to_i

def move(log)
  p '======='
  p log
  return 1 if log.size == N + 1

  cnt = 0
  [[0, 1], [0, -1], [-1, 0], [-1, 0]].each{ |d|
    p 'log[-1]'
    p log[-1]
    next_pos = [log[-1][0] + d[0], log[-1][1] + d[1]]
    p next_pos
    if !log.include?(next_pos) then
      cnt += move(log + [next_pos])
    end
  }
  p 'return'
  p cnt
  cnt
end

puts move([[0,0]])