# 3. Заполнить массив числами фибоначи до 100

fib = [0,1]
i = 2

loop do
  next_fib = fib[i-1] + fib[i-2] 
  break if next_fib >= 100
  fib << next_fib
  i += 1
end

print fib