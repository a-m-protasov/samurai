puts "Введите длины сторон треугольника"
print "1й : "
a1 = gets.chomp.to_f
print "2й : "
a2 = gets.chomp.to_f
print "3й : "
a3 = gets.chomp.to_f

if a1==a2 && a2==a3
	puts "Треугольник-то равносторонний!" #И дальше можно не смотреть
else
	# Равнобедренный?
	isosceles = a1==a2 || a1==a3 || a2==a3

	# Определяем длину стороны, которая может быть гипотенузой
	hyp = [a1,a2,a3].max

	# Определяем длины потенциальных катетов
	if a1 == hyp
		cat1 = a2
		cat2 = a3
	elsif a2 == hyp
		cat1 = a1
		cat2 = a3
	else
		cat1 = a1
		cat2 = a2	
	end
	
	if cat1 + cat2 < hyp
		puts "Да это вообще не треугольник..."  
	elsif hyp**2 == cat1**2 + cat2**2
		puts "Ура! Треугольник прямоугольный"
		puts "И к тому же равнобедренный" if isosceles
	else 
		puts "Треугольник не является прямоугольным"
		puts "Зато он равнобедренный" if isosceles
	end
end




