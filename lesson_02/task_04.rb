# 4. Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

alphabet = "абвгдеёжзийклмнопрстуфхцчшщъыьэюя"
vowels= "аеёиоуыэюя"
vowels_hash = {}

for i in 0..vowels.length - 1
  vowels_hash[vowels[i]] = alphabet.index(vowels[i]) + 1
end

print vowels_hash