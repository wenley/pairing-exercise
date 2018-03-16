require 'spec_helper'
require 'conway_game'

RSpec.describe ConwayGame do
  describe 'constructor' do
    subject(:game) { described_class.new(arg) }
    let(:arg) { [[false, false], [false, false]] }

    it 'builds a board' do
      expect { subject }.to_not raise_error
      expect(game.to_s).to eq("  \n  ")
    end

    context 'with no values' do
      let(:arg) { [] }

      it 'works' do
        expect(subject.to_s).to eq('')
      end
    end

    context 'with living cells' do
      let(:arg) { [[true, false]] }

      it 'works' do
        expect(subject.to_s).to eq('o ')
      end
    end
  end

  describe '#neighbors_around' do
    let(:board) do
      [
        [0, 0, 0],
        [0, 0, 0],
        [0, 0, 0],
      ]
    end
    let(:receiver) { Proc.new {} }
    let(:game) { described_class.new(board) }
    let(:x) { 1 }
    let(:y) { 1 }
    subject { game.neighbors_around(x, y, &receiver) }

    it 'yields 8 values' do
      expect(receiver).to receive(:call).with(0).exactly(8).times
      subject
    end

    context 'with different values' do
      let(:board) do
        [
          [1, 2, 0],
          [2, 3, 1],
          [0, 1, 0],
        ]
      end

      it 'yields the correct values' do
        expect(receiver).to receive(:call).with(0).exactly(3).times
        expect(receiver).to receive(:call).with(1).exactly(3).times
        expect(receiver).to receive(:call).with(2).exactly(2).times
        expect(receiver).to receive(:call).with(3).exactly(0).times
        subject
      end
    end
  end

  describe '#alive_neighbor_count' do
    let(:board) do
      [
        [true, false, true],
        [false, false, false],
        [true, true, false],
      ]
    end
    let(:game) { described_class.new(board) }

    it 'has the right counts' do
      expect(game.alive_neighbor_count(0, 0)).to eq(0)
      expect(game.alive_neighbor_count(0, 1)).to eq(2)
      expect(game.alive_neighbor_count(1, 0)).to eq(3)
      expect(game.alive_neighbor_count(1, 1)).to eq(4)
    end
  end

  describe '#step' do
    let(:game) { described_class.new(board) }

    context 'empty board' do
      let(:board) { [[]] }

      it 'still runs' do
        expect(game.to_s).to eq('')
        game.step
        expect(game.to_s).to eq('')
      end
    end

    context 'blinker' do
      let(:board) { [[true, true, true]] }

      it 'cycles' do
        expect(game.to_s).to eq('ooo')
        game.step
        expect(game.to_s).to eq("o\no\no")
        game.step
        expect(game.to_s).to eq('ooo')
        100.times { game.step }
        expect(game.to_s).to eq('ooo')
      end
    end

    context 'stable' do
      let(:board) do
        [
          [true, false],
          [true, true],
        ]
      end

      it 'stays around' do
        expect(game.to_s).to eq("o \noo")
        game.step
        expect(game.to_s).to eq("oo\noo")
        game.step
        expect(game.to_s).to eq("oo\noo")
        100.times { game.step }
        expect(game.to_s).to eq("oo\noo")
      end
    end

    context 'unstable' do
      let(:board) do
        [
          [false, true, true, false],
          [true, false, false, true],
          [false, false, true, false],
        ]
      end

      it 'dies' do
        expect(game.to_s).to_not eq('')
        game.step
        expect(game.to_s).to_not eq('')
        game.step
        expect(game.to_s).to_not eq('')
        game.step
        expect(game.to_s).to eq('')
      end
    end
  end
end
