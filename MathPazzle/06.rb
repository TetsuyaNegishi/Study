Max = 10000

def Collatz(n)
  check = 3 * n + 1
  loop do
    return false if check == 1
    return true if check == n
    if check.even? then
      check /= 2
    else
      check = 3 * check + 1
    end
  end
end

p 2.step(Max, 2).count {|n|
  Collatz(n)
}
