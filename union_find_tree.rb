#! /usr/bin/ruby -Ku
# -*- coding: utf-8 -*-
# Author: Yasutaka SHINDOH / 新堂 安孝

############################################################
## ユニオン・ファインド・ツリー
class UnionFindTree

    ##############################
    # コンストラクタ
    public
    def initialize
        @table = Hash::new
    end

    ##############################
    # 要素数を取得
    public
    def size
        @table.size
    end

    ##############################
    # 要素数を取得
    public
    def length
        @table.length
    end

    ##############################
    # 空かどうかを確認
    public
    def empty?
        @table.empty?
    end

    ##############################
    # 要素・集合を追加
    public
    def add(object, parent=nil)
        unless @table[object] then
            if parent and @table[parent] then
                parent = find(parent)
                @table[object] = [parent, 1]
                @table[parent][1] += 1 if @table[parent][1] == 1
            else
                @table[object] = [object, 1]
            end
        end
    end

    ##############################
    # 集合の代表元を取得
    public
    def find(object)
        return nil unless @table[object]

        if @table[object][0] != object then
            @table[object][0] = find(@table[object][0])
        end

        return @table[object][0]
    end

    ##############################
    # 集合を結合
    public
    def unite(first, second)
        if @table[first] and @table[second] then
            first = find(first)
            second = find(second)
            if first != second then
                if @table[first][1] > @table[second][1] then
                    @table[second][0] = @table[first][0]
                else
                    @table[first][0] = @table[second][0]
                    @table[second][1] += 1 if @table[first][1] == @table[second][1]
                end
            end
        end
    end

    ##############################
    # 2集合が同一集合かどうかを確認
    public
    def same(first, second)
        return find(first) == find(second)
    end

    ##############################
    # 文字列に変換
    public
    def to_s
        @table.to_s
    end
end

############################################################
## 動作確認用コード
if __FILE__ == $PROGRAM_NAME then
    uf_tree = UnionFindTree::new
    array = [5, 3, 0, 6, 1, 9]

    array.length.times { |i|
        uf_tree.add(array[i])
    }

    puts uf_tree

    uf_tree.unite(6, 1)
    puts uf_tree

    uf_tree.unite(6, 0)
    puts uf_tree

    uf_tree.unite(5, 3)
    puts uf_tree

    uf_tree.unite(3, 1)
    puts uf_tree

    uf_tree.find(5)
    puts uf_tree

    puts uf_tree.same(3, 6)
    puts uf_tree.same(3, 9)
end
