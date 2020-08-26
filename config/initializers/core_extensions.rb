class Array
  def to_struct
    RecursiveOpenStruct.new self, recurse_over_arrays: true
  end

  def to_structs
    self.map { |d| RecursiveOpenStruct.new d, recurse_over_arrays: true }
  end
end

class Hash
  def to_struct
    RecursiveOpenStruct.new self, recurse_over_arrays: true
  end

  if Rails.env == "test"
    def puts_keys
      puts "[:#{self.keys.join(", :")}]"
      puts "=" * 20
    end
  end
end

class String
  if Rails.env == "test"
    def self.random(length = 1)
      (rand(36**(length - 1)) + 36**(length - 1)).to_s(36)
    end

    def self.random_number(length = 1)
      (rand(10**(length - 1)) + 10**(length - 1)).to_s(10)
    end
  end
end

class Date
  def display_date
    self.strftime("%d/%m/%Y")
  end

  def self.last
    AppConstant::APP_END_DATE
  end

  def dbsale_format
    self.strftime("%d/%m/%Y")
  end

  def wrap_oracle_to_date
    "TO_DATE('#{self.dbsale_format}', 'DD/MM/YYYY')"
  end

  def wrap_oracle_to_date_time
    "TO_DATE('#{self.dbsale_format} 00:00:00', 'DD/MM/YYYY HH24:MI:SS')"
  end
end

class Time
  def dbsale_format
    self.strftime("%d/%m/%Y %H:%M:%S")
  end

  def wrap_oracle_to_date_time
    "TO_DATE('#{self.dbsale_format}', 'DD/MM/YYYY HH24:MI:SS')"
  end
end
