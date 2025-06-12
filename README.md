# t_ring

このスクリプトは、プレイヤーがオリジナルの名前を付けた指輪を作成できます

------

# 依存関係
- `"qb-core"`
- `"ox_inventory"`
- 依存関係の後に起動してください

------

## インストール

- フォルダ名から `-main` を削除します。
- `server.cfg` に `ensure t_ring` を追加します
- ox_inventory/data/items.luaにアイテムを作成します

--ox_inventory/data/items.lua
```
['custom_ring'] = {
    label = 'custom ring',
    description = 'ring',
    weight = 1,
    stack = false,
}
```
- t_ring/cnofig.luaのConfig.RingItemを作成したアイテムの名前に設定します

-- t_ring/cnofig.lua
```
Config.RingItem = 'custom_ring'
```
