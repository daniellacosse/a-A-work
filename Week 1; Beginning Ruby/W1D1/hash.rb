  def set_add_el(hsh, symbl)
    hsh[symbl] = true
  end

  def set_remove_el(hsh, symbl)
    hsh[symbl].delete
  end

  def set_list_els?(hsh)
    hsh.keys
  end

  def set_member?(hsh, symbl)
    hsh.has_key?(symbl)
  end

  def set_union(hsh1, hsh2)
    hsh1.merge(hsh2)
  end

  def set_intersection(hsh1, hsh2)
    hsh1.select{|key, value| hsh2.has_key?(key)}
  end

  def set_minus(hsh1,hsh2)
    hsh1.select{|key, value| !hsh2.has_key?(key)}
  end

  #hash1 = {:x => true, :y => true}
  #hash2 = {:y => true, :z => true}
  #p set_intersection(hash1,hash2)
  #p set_minus(hash1,hash2)

  def correct_hash(hsh)
    new_hsh = {}
    hsh.each do |key, value|
      new_hsh[value[0].to_sym] = value
    end
    new_hsh
  end

  wrong_hash = { :a => "banana", :b => "cabbage", :c => "dental_floss", :d => "eel_sushi" }
  p correct_hash(wrong_hash)