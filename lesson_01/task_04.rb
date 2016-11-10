puts "Решаем квадратное уравнение. Введите"
print "a : "
a = gets.chomp.to_f
print "b : "
b = gets.chomp.to_f
print "c : "
c = gets.chomp.to_f

d = b**2 - 4*a*c
puts "D = #{d}"

if d < 0
	puts "Корней нет"
elsif d == 0
	x1 = -b / 2*a
	puts "x1 = x2 = #{x1}"
else
  root_of_the_d = Math.sqrt(d)
	x1 = (-b + root_of_the_d) / 2*a
	x2 = (-b - root_of_the_d) / 2*a
	puts "x1 = #{x1}, x2 = #{x2}"
end
