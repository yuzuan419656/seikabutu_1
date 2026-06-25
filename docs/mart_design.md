# 用意したいテーブルの要素

| 列名             | 説明     | 元テーブル       |
| -------------- | ------ | ----------- |
| order_id       | 注文ID   | orders      |
| review_score   | レビュー評価 | reviews     |
| customer_state | 顧客州    | customers   |
| item_count     | 商品数    | order_items |
| total_price    | 商品合計金額 | order_items |
| total_freight  | 送料合計   | order_items |
| payment_type   | 支払い方法  | payments    |
| payment_value  | 支払金額   | payments    |
| delivery_days  | 配送日数   | orders      |
| delay_days     | 配送遅延日数 | orders      |
| main_category | 注文内で最も多い商品カテゴリ | products + order_items |


# 各要素の詳細

## review_score
目的変数候補、低評価レビューを review_score <= 2 と定義する可能性がある
## item_count
一つの注文で同時に注文された商品の数→order_itemsをorder_idでgroup byしてからcount(*)で一注文に含まれる商品数をカウントする。
## total_price
一注文の合計金額→order_itemsをorder_idでgroup byしてからsum(price)で一注文の合計金額を算出する。
## total_freight
一注文の送料合計→order_itemsをorder_idでgroup byしてからsum(freight_value)で一注文の送料合計を算出する。
## payment_type
一注文における支払方法→一注文に複数の支払い方法が存在する場合は、payment_valueが最大の支払いレコードのpayment_typeを採用する。
## payment_value
一注文における総支払金額→paymentsをorder_idでgroup byしてからsum(payment_value)で一注文の合計支払い金額を算出する。
## delivery_days 
配送にかかった日数→order_delivered_customer_dateとorder_purchase_timestampの差で算出。
## delay_days
配送遅延が何日分あったか→order_delivered_customer_dateとorder_estimated_delivery_dateの差で算出。値がマイナス（配送遅延なし）の場合には、予定日より早く到着した場合であり遅延ではないため0とする。
欠損値に対する対応→配送完了注文のみを対象とするか、欠損値として保持するかは後で検討する。現時点での予定は配送完了注文のみを対象とする。
## main_category
同一注文内で最も数が多いカテゴリーを採用。同率であれば合計金額が多いものを採用。

## review_score

目的変数候補。

一部の注文では複数レビューが存在することを確認した。
レビューは時系列に沿って更新されていると考えられるため、
review_answer_timestamp が最も新しいレコードの
review_score を採用する。

集約方法:
ROW_NUMBER() OVER (
  PARTITION BY order_id
  ORDER BY review_answer_timestamp DESC
) as rn

rn = 1 を採用する。