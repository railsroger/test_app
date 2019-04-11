DataShift::Configuration.call do |c|
  c.verbose = false
  c.remove_columns = %i[updated_at id]
end
