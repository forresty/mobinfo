# MobInfo

lookup ISP and geo info (province, city etc) for mobile number in China

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mobinfo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mobinfo

## Usage

```ruby
MobInfo.lookup('1862169')
# => {:province=>"上海", :city=>"上海", :postal_code=>"200000", :region_code=>"021", :isp=>"联通", :prefix=>1862169}

MobInfo.lookup(110)
# => nil
```

## Credits

`phone.dat`, idea and algorithm from [https://github.com/lovedboy/phone](https://github.com/lovedboy/phone)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/forresty/mobinfo.

