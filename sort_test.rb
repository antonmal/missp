votes = {
  'HAM' => 1,
  'PIZ' => 4,
  'CUR' => 8,
  'NOO' => 5,
}
def sort_desc(hsh)
  new_hsh = {}
  key_array = hsh.keys
  value_array = hsh.values
  key_counter = 0

  until key_counter == key_array.length() do

    for i in 1...value_array.length()
      if (value_array[i]) > (value_array[i - 1])

        bigger_value = value_array[i]
        value_array[i] = value_array[i - 1]
        value_array[i - 1] = bigger_value

        bigger_key = key_array[i]
        key_array[i] = key_array[i - 1]
        key_array[i - 1] = bigger_key

      end
    end
    key_counter += 1

  end

  for i in 0...key_array.length()
    new_hsh.store(key_array[i], value_array[i])
  end

  return new_hsh
end

sort_desc(votes)
