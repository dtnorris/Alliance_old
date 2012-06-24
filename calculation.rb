puts "Hello, Ruby Programmer"

xp_per_bp = 3
tmp_bp = 15
tmp_xp = 100000
tmp_lvl = 1

# while tmp_xp > 0
#   if (tmp_xp - xp_per_bp) >= 0
#     tmp_bp = tmp_bp + 1
#   end
#   tmp_xp = tmp_xp - xp_per_bp
#   if (((tmp_bp - 15) / 10) + 1) == (tmp_lvl + 1)
#     tmp_lvl += 1
#     xp_per_bp = xp_per_bp + tmp_lvl + 2
#   end
# end

while tmp_xp > 0
  if tmp_xp >= xp_per_bp
    tmp_bp += 1
  end
  tmp_xp -= xp_per_bp
  if ((tmp_bp - 15) / 10) == tmp_lvl
    tmp_lvl += 1
    xp_per_bp += tmp_lvl + 2
  end
end

puts xp_per_bp
puts tmp_bp
puts tmp_xp
puts tmp_lvl