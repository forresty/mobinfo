require 'spec_helper'

describe MobInfo do
  it 'has a version number' do
    expect(MobInfo::VERSION).not_to be nil
  end

  it 'finds number' do
    expect(MobInfo.lookup(1300000)[:city]).to eq('济南')
    expect(MobInfo.lookup('1300000')[:city]).to eq('济南')
    expect(MobInfo.lookup('1862169')[:province]).to eq('上海')
    expect(MobInfo.lookup('1862169')[:isp]).to eq('联通')
    expect(MobInfo.lookup('18621690000')[:province]).to eq('上海')
    expect(MobInfo.lookup(18621690000)[:province]).to eq('上海')
    expect(MobInfo.lookup('+86-18621690000')[:province]).to eq('上海')
    expect(MobInfo.lookup('+86-18621690000')[:prefix]).to eq(1862169)
    expect(MobInfo.lookup('+852-67470000')[:province]).to eq('未知')
    expect(MobInfo.lookup('2000000')[:city]).to eq('未知')
    expect(MobInfo.lookup(nil)[:city]).to eq('未知')
    expect(MobInfo.lookup(1)[:city]).to eq('未知')
    expect(MobInfo.lookup(110)[:city]).to eq('未知')
    expect(MobInfo.lookup('')[:city]).to eq('未知')
    expect(MobInfo.lookup('-')[:city]).to eq('未知')
  end
end
