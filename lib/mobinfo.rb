require "mobinfo/version"

module MobInfo
  @@data = File.read(File.expand_path('../../data/phone.dat', __FILE__), mode: 'rb')
  @@data_version = @@data[0..3]
  @@first_index_offset = @@data[4..7].unpack('l').first

  def self.record_at_offset(offset)
    string = @@data[offset..-1].unpack('Z*').first.force_encoding('utf-8')

    province, city, postal_code, region_code = string.split('|')

    { province: province, city: city, postal_code: postal_code, region_code: region_code }
  end

  def self.binary_search(prefix, from=0, to=nil)
    if to.nil?
      to = ((@@data.size - @@first_index_offset) / 9).to_i
    end

    if from > to
      return [prefix, nil, nil]
    end

    mid = (from + to) / 2

    index_offset = mid * 9 + @@first_index_offset

    first_7digits, record_offset, type = @@data[index_offset, index_offset+9].unpack('l2c')

    if first_7digits.nil?
      return [prefix, nil, nil]
    end

    if prefix < first_7digits
      binary_search(prefix, from, mid - 1)
    elsif prefix > first_7digits
      binary_search(prefix, mid + 1, to)
    else
      [first_7digits, record_offset, type]
    end
  end

  def self.lookup(number)
    number = number.to_s
    number = number[4..-1] if number =~ /\+86-/

    prefix = number[0...7].to_i

    first_7digits, record_offset, type = binary_search(prefix)

    if type
      isp = case type.to_i
      when 1 then '移动'
      when 2 then '联通'
      when 3 then '电信'
      when 4 then '电信虚拟运营商'
      when 5 then '联通虚拟运营商'
      when 6 then '移动虚拟运营商'
      else '未知运营商'
      end

      record_at_offset(record_offset).merge(isp: isp, prefix: first_7digits)
    end
  end
end
