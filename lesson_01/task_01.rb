print "Как вас зовут?  "
name = gets.chomp 
print "Какого вы роста?  "
height = gets.chomp.to_i

ideal_weight = height - 110

if ideal_weight < 0
	puts "Ваш вес уже оптимальный"
else
	puts "#{name}, ваш идеальный вес - #{ideal_weight} кг"
end

