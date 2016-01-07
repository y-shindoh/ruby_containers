#! /usr/bin/ruby -Ku
# -*- coding: utf-8 -*-
# Author: Yasutaka SHINDOH / 新堂 安孝

############################################################
## バイナリー・インデックス・ツリー (BIT)
class BinaryIndexedTree

    ##############################
    # コンストラクタ
    # [argument] BITで扱う区間の長さ or 各区間の値
    public
    def initialize(argument=nil)
        @array = nil
        prepare(argument) if argument
    end

    ##############################
    # 処理の準備
    # [argument] BITで扱う区間の長さ or 各区間の値
    public
    def prepare(argument)
        if argument.kind_of?(Array) then
            @array = Array::new(argument.length, 0)
            argument.each_index { |i| add(i, argument[i]) }
        else
            @array = Array::new(length, 0)
        end
    end

    ##############################
    # 指定区間の値を加算
    # [i] 指定区間のインデックス
    # [v] 加算する値
    public
    def add(i, v)
        if i == 0 then
            @array[0] += v
        else
            l = @array.length

            while i < l do
                @array[i] += v
                i += i & (~i + 1)	# 最下位ビットを繰り上げ
            end
        end
    end

    ##############################
    # 0からのパスの総コストを取得
    # [i] 指定区間のインデックス
    private
    def sum_routine(i)
        v = @array[0]

        while 0 < i do
            v += @array[i]
            i &= i - 1		# 最下位ビットを0に変更
        end

        v
    end

    ##############################
    # パスの総コストを取得
    # [f] 最初のエッジの始点ノード or 最後のエッジの終点ノード
    # [t] 最後のエッジの終点ノード or nil
    public
    def sum(i, j=nil)
        if j then
            sum_routine(j) - sum_routine(i)
        else
            sum_routine(i)
        end
    end
end

############################################################
## 動作確認用コード
if __FILE__ == $PROGRAM_NAME then
    def my_print(f, t, bit)
        i = f.bytes.first - 'A'.bytes.first
        j = t.bytes.first - 'A'.bytes.first
        printf("[%s->%s]\t%d\n", f, t, bit.sum(i, j))
    end

    DATA = [0, 118, 191, 410, 598, 129, 493, 334, 357, 432]
    INPUT = [['A', 'B'], ['A', 'C'], ['C', 'D'], ['A', 'E'], ['E', 'F'],
			 ['E', 'G'], ['G', 'H'], ['A', 'I'], ['I', 'J']]
    bit = BinaryIndexedTree::new(DATA)

    for v in INPUT do
        my_print(v[0], v[1], bit)
    end
end
