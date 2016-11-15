# 3. Заполнить массив числами фибоначи до 100

fib = [0,1]

loop do
  next_fib = fib[-1] + fib[-2] 
  break if next_fib >= 100
  fib << next_fib
end

print fib