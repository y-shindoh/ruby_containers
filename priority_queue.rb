#! /usr/bin/ruby -Ku
# -*- coding: utf-8 -*-
# Author: Yasutaka SHINDOH / 新堂 安孝

############################################################
## 優先度つきキュー
class PriorityQueue

    ##############################
    # コンストラクタ
    public
    def initialize(compare, array=nil)
        @array = nil
        @compare = compare	# 第2引数を上に持ち上げる => true
        if array then
            @array = array.dup
            (@array.length / 2).downto(0) { |i|
                heapy_down(i)
            }
        else
            @array = Array::new
        end
    end

    ##############################
    # 要素数を取得
    public
    def size
        @array.size
    end

    ##############################
    # 要素数を取得
    public
    def length
        @array.length
    end

    ##############################
    # キューが空かどうかを確認
    public
    def empty?
        @array.empty?
    end

    ##############################
    # 指定要素をヒープ条件を満たすよう持ち上げる
    private
    def heapy_up(i)
        while 0 < i do
            j = (i - 1) / 2
            break if @compare.call(@array[j], @array[i])
            tmp = @array[j]
            @array[j] = @array[i]
            @array[i] = tmp
            i = j
        end
    end

    ##############################
    # 指定要素をヒープ条件を満たすよう押し下げる
    private
    def heapy_down(i)
        l = @array.length
        while i < l do
            j = i * 2 + 1
            break unless j < l
            k = j + 1
            j = k if k < l and @compare.call(@array[k], @array[j])
            break if @compare.call(@array[i], @array[j])
            tmp = @array[j]
            @array[j] = @array[i]
            @array[i] = tmp
            i = j
        end
    end

    ##############################
    # 要素を追加
    public
    def push(data)
        if data.kind_of?(Array) then
            l = @array.length
            data.each_index { |i|
                @array.push(data[i])
                heapy_up(l+i)
            }
        else
            i = @array.length
            @array.push(data)
            heapy_up(i)
        end
    end

    ##############################
    # 先頭要素を取得・除去
    public
    def pop
        data = nil
        i = @array.length - 1
        if 0 <= i then
            data = @array.first
            if 1 <= i then
                tmp = @array[i]
                @array[0] = tmp
            end
            @array.pop
            heapy_down(0)
        end
        data
    end

    ##############################
    # 先頭要素を取得
    public
    def top
        if @array.empty then
            nil
        else
            @array.first
        end
    end

    ##############################
    # 文字列に変換
    public
    def to_s
        @array.to_s
    end
end

############################################################
## 動作確認用コード
if __FILE__ == $PROGRAM_NAME then
    def my_compare(l, r)
        return l < r
    end

    priority_queue = PriorityQueue::new(method(:my_compare), [5, 6, 8])

    puts priority_queue

    priority_queue.push([9, 5])

    puts priority_queue

    for x in [0, 6, 1] do
        priority_queue.push(x)
    end

    until priority_queue.empty? do
        puts priority_queue
        puts priority_queue.pop
    end
end
