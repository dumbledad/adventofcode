# frozen_string_literal: true

require './day18'
using Refinements

# https://adventofcode.com/2021/day/17
RSpec.describe String do
  describe '#to_sn' do
    it 'correctly parses a snailfish number string' do
      sn_string = '[[1,2],3]'
      sn = sn_string.to_sn
      expect(sn.left.parent).to eq(sn)
      # 1
      expect(sn.left.left.parent).to eq(sn.left)
      expect(sn.left.left.left).to be_nil
      expect(sn.left.left.right).to be_nil
      expect(sn.left.left.value).to eq(1)
      # 2
      expect(sn.left.right.parent).to eq(sn.left)
      expect(sn.left.right.left).to be_nil
      expect(sn.left.right.right).to be_nil
      expect(sn.left.right.value).to eq(2)
      # 3
      expect(sn.right.parent).to eq(sn)
      expect(sn.right.left).to be_nil
      expect(sn.right.right).to be_nil
      expect(sn.right.value).to eq(3)
    end
  end
end

RSpec.describe SnailfishNumber do
  describe '#to_a' do
    it 'correctly renders a snailfish number as an array' do
      sn = '[[1,2],[[3,4],[5,6]]]'.to_sn
      expect(sn.to_a).to eq([[1, 2], [[3, 4], [5, 6]]])
    end
  end

  describe '#add' do
    it 'correctly adds two snailfish numbers' do
      sum = '[1,2]'.to_sn + '[[3,4],[[5,6],[7,8]]]'.to_sn
      expect(sum.to_a).to eq([[1, 2], [[3, 4], [[5, 6], [7, 8]]]])
      expect(sum.left.parent).to eq(sum)
    end
  end

  describe '#to_explode' do
    it 'correctly picks the first pair to explode' do
      example = '[[[[[9,8],1],2],3],4]'.to_sn
      expect(example.to_explode(0).to_a).to eq([9, 8])
      example = '[7,[6,[5,[4,[3,2]]]]]'.to_sn
      expect(example.to_explode(0).to_a).to eq([3, 2])
      example = '[[6,[5,[4,[3,2]]]],1]'.to_sn
      expect(example.to_explode(0).to_a).to eq([3, 2])
      example = '[[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]]'.to_sn
      expect(example.to_explode(0).to_a).to eq([7, 3])
      example = '[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]'.to_sn
      expect(example.to_explode(0).to_a).to eq([3, 2])
    end
  end

  describe '#explode' do
    it 'correctly explodes pair' do
      example = '[[[[[9,8],1],2],3],4]'.to_sn
      example.to_explode(0).explode
      expect(example.to_a).to eq([[[[0, 9], 2], 3], 4])

      example = '[7,[6,[5,[4,[3,2]]]]]'.to_sn
      example.to_explode(0).explode
      expect(example.to_a).to eq([7, [6, [5, [7, 0]]]])

      example = '[[6,[5,[4,[3,2]]]],1]'.to_sn
      example.to_explode(0).explode
      expect(example.to_a).to eq([[6, [5, [7, 0]]], 3])

      example = '[[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]]'.to_sn
      example.to_explode(0).explode
      expect(example.to_a).to eq([[3, [2, [8, 0]]], [9, [5, [4, [3, 2]]]]])

      example = '[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]'.to_sn
      example.to_explode(0).explode
      expect(example.to_a).to eq([[3, [2, [8, 0]]], [9, [5, [7, 0]]]])
    end
  end

  describe '#magnitude' do
    it 'correctly works out the magnitude of a snailfish number' do
      example = '[[1,2],[[3,4],5]]'.to_sn
      expect(example.magnitude).to eq(143)
      example = '[[[[0,7],4],[[7,8],[6,0]]],[8,1]]'.to_sn
      expect(example.magnitude).to eq(1384)
      example = '[[[[1,1],[2,2]],[3,3]],[4,4]]'.to_sn
      expect(example.magnitude).to eq(445)
      example = '[[[[3,0],[5,3]],[4,4]],[5,5]]'.to_sn
      expect(example.magnitude).to eq(791)
      example = '[[[[5,0],[7,4]],[5,5]],[6,6]]'.to_sn
      expect(example.magnitude).to eq(1137)
      example = '[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]'.to_sn
      expect(example.magnitude).to eq(3488)
      example = '[[[[7,8],[6,0]],[[6,6],[7,8]]],[[[9,8],[7,8]],[[7,9],[6,6]]]]'.to_sn
      expect(example.magnitude).to eq(4233)
    end
  end

  describe 'magnitude of sum' do
    it 'correctly ascertains the magnitude of the sum of two snailfish numbers' do
      sn1 = '[[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]'.to_sn
      sn2 = '[[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]'.to_sn
      # Sum reduces to [[[[7,8],[6,6]],[[6,0],[7,7]]],[[[7,8],[8,8]],[[7,9],[0,6]]]]
      expect((sn1 + sn2).magnitude).to eq(3993)
      sn1 = '[[[7,8],[6,0]],[[6,6],[7,8]]]'.to_sn
      sn2 = '[[[9,8],[7,8]],[[7,9],[6,6]]]'.to_sn
      expect((sn1 + sn2).magnitude).to eq(4233)
    end
  end

  describe 'magnitude of multiple sums' do
    it 'gets the correct maximum for multiple sums' do
      sn_numbers =
        [
          '[[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]'.to_sn,
          '[[[5,[2,8]],4],[5,[[9,9],0]]]'.to_sn,
          '[6,[[[6,2],[5,6]],[[7,6],[4,7]]]]'.to_sn,
          '[[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]'.to_sn,
          '[[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]'.to_sn,
          '[[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]'.to_sn,
          '[[[[5,4],[7,7]],8],[[8,3],8]]'.to_sn,
          '[[9,3],[[9,9],[6,[4,9]]]]'.to_sn,
          '[[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]'.to_sn,
          '[[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]'.to_sn
        ]
      magnitudes = []
      sn_numbers.each do |sn1|
        sn_numbers.each do |sn2|
          next if sn1 == sn2

          magnitudes << (sn1 + sn2).magnitude
          magnitudes << (sn2 + sn1).magnitude
        end
      end
      expect(magnitudes.max).to eq(3993)
    end
  end
end
