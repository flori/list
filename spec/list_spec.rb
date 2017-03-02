require 'spec_helper'

describe List do
  let :list do
    described_class.new
  end

  it 'can be instantiated' do
    expect(list).to be_a List
  end

  describe '.[]' do
    let :list do
      List[ 1, 2, 3 ]
    end

    it 'is a prefilled list' do
      expect(list.to_a).to eq [ 1, 2, 3 ]
    end
  end

  describe '#insert' do
    it 'can be inserted into at 0' do
      l = list.insert :something, at: 0
      expect(l).to be_a List
      expect(list.size).to eq 1
    end

    it 'cannot be inserted into at 1' do
      l = list.insert :something, at: 1
      expect(l).to be_nil
      expect(list.size).to eq 0
    end

    it 'can be inserted into at 0' do
      l = list
      expect(l.size).to eq 0
      l = list.insert :foo, at: 0
      expect(l).to be_a List
      expect(l.size).to eq 1
      l = list.insert :bar, at: 0
      expect(l).to be_a List
      expect(l.size).to eq 2
      l = list.insert :baz, at: 0
      expect(l).to be_a List
      expect(l.size).to eq 3
      expect(l.each.to_a).to eq %i[ baz bar foo ]
    end

    it 'can be inserted into at any location' do
      l = list
      expect(l.size).to eq 0
      l = list.insert :foo, at: 0
      expect(l).to be_a List
      expect(l.size).to eq 1
      l = list.insert :bar, at: 1
      expect(l).to be_a List
      expect(l.size).to eq 2
      l = list.insert :baz, at: 1
      expect(l).to be_a List
      expect(l.size).to eq 3
      expect(l.each.to_a).to eq %i[ foo baz bar ]
    end

    it 'can be inserted into from behind' do
      l = list
      expect(l.size).to eq 0
      l = list.insert :foo, at: -1
      expect(l).to be_a List
      expect(l.size).to eq 1
      l = list.insert :bar, at: -2
      expect(l).to be_a List
      expect(l.size).to eq 2
      l = list.insert :baz, at: -2
      expect(l).to be_a List
      expect(l.size).to eq 3
      expect(l.each.to_a).to eq %i[ bar baz foo ]
    end
  end

  describe '#delete' do
    let :list do
      List[ 1, 2, 3 ]
    end

    it 'can be deleted from front' do
      list.delete at: 0
      expect(list.to_a).to eq [ 2, 3 ]
    end

    it 'can be deleted from back' do
      list.delete at: -1
      expect(list.to_a).to eq [ 1, 2 ]
    end

    it 'can be deleted from front in the middle' do
      list.delete at: 1
      expect(list.to_a).to eq [ 1, 3 ]
    end

    it 'can be deleted from back in the middle' do
      list.delete at: -2
      expect(list.to_a).to eq [ 1, 3 ]
    end

    it 'can be deleted from front all the way' do
      list.delete at: 0
      expect(list.to_a).to eq [ 2, 3 ]
      list.delete at: 0
      expect(list.to_a).to eq [ 3 ]
      list.delete at: 0
      expect(list.to_a).to eq [ ]
    end

    it 'can be deleted from back all the way' do
      list.delete at: -1
      expect(list.to_a).to eq [ 1, 2 ]
      list.delete at: -1
      expect(list.to_a).to eq [ 1 ]
      list.delete at: -1
      expect(list.to_a).to eq [ ]
    end
  end

  describe '#size' do
    let :list do
      List[ 1, 2, 3 ]
    end

    it 'can return size' do
      expect(list.size).to eq 3
    end
  end

  describe '#empty?' do
    let :list do
      List[ 1 ]
    end

    it 'can return false result' do
      expect(list).not_to be_empty
    end

    it 'can return true result' do
      list.delete at: 0
      expect(list).to be_empty
    end
  end

  describe '#index' do
    before do
      list.insert :foo, at: 0
      list.insert :bar, at: 1
      list.insert :baz, at: 2
    end

    it 'can be nil if not existant' do
      expect(list.index(:nix)).to be_nil
    end

    it 'is integer number if existant' do
      expect(list.index(:bar)).to eq 1
    end
  end

  describe '#each' do
    before do
      list.insert :foo, at: 0
      list.insert :bar, at: 1
      list.insert :baz, at: 2
    end

    it 'can be converted to array' do
      expect(list.to_a).to eq %i[ foo bar baz ]
    end
  end
end
