# Olist Dataset Overview

## customers

### 粒度

1行 = 顧客情報

### 主キー候補

* customer_id

### 主なカラム

* customer_unique_id
* customer_city
* customer_state

### 確認したこと

* customer_id は一意かつ欠損なし
* orders テーブルにも登場する
* customer_unique_id は欠損なしだが重複が存在する
* customer_id と customer_unique_id の役割の違いは今後調査が必要
* customer_state は顧客の居住州を表していると考えられる

---

## geolocation

### 粒度

郵便番号周辺の位置情報

### 確認したこと

* 主キーとして利用できそうなカラムは見つからなかった
* 今回の分析では利用しない可能性が高い
* 地理情報を扱う際に利用できそう

---

## orders

### 粒度

1行 = 1注文

### 主キー候補

* order_id

### 外部キー候補

* customer_id → customers

### 主なカラム

* order_status
* order_purchase_timestamp
* order_delivered_customer_date

### 確認したこと

* order_id は一意かつ欠損なし
* customer_id は重複する
* 注文日時や配送日時などの注文情報を保持している
* 分析の中心となるテーブルである

---

## order_items

### 粒度

1行 = 注文内の商品1件

### 主キー候補

* (order_id, order_item_id)

### 外部キー候補

* order_id → orders
* product_id → products
* seller_id → sellers

### 主なカラム

* price
* freight_value

### 確認したこと

* order_id は重複する
* 1注文に複数の商品が含まれる
* 商品価格や送料情報を保持している
* 1注文あたりの商品数は平均約1.14件
* 最大21商品を含む注文が存在する

---

## order_payments

### 粒度

1行 = 支払い情報1件

### 外部キー候補

* order_id → orders

### 主なカラム

* payment_type
* payment_installments
* payment_value

### 確認したこと

* order_id は重複する
* 1注文に複数の支払いレコードが存在する
* 支払い方法や分割回数などの情報を保持している
* 1注文あたりの支払い件数は平均約1.04件
* 最大29件の支払いレコードが存在する

---

## order_reviews

### 粒度

1行 = レビュー情報

### 外部キー候補

* order_id → orders

### 主なカラム

* review_score

### 確認したこと

* review_score は1〜5の5段階評価
* order_id と review_id に重複が存在する
* 重複が発生する理由は未調査
* 注文数とレビュー数は一致しない
* レビューが存在しない注文がある

---

## products

### 粒度

1行 = 商品

### 主キー候補

* product_id

### 主なカラム

* product_category_name
* product_weight_g

### 確認したこと

* product_id は一意かつ欠損なし
* 商品カテゴリや重量などの商品情報を保持している

---

## sellers

### 粒度

1行 = 出品者情報

### 主キー候補

* seller_id

### 主なカラム

* seller_city
* seller_state

### 確認したこと

* seller_id は order_items テーブルに登場する
* seller_state は出品者所在地を表していると考えられる
* customer_state と同様にブラジルの州コードが格納されている

---

## テーブル間の関係

customers
↓
orders
↓
order_items
↓
products

orders
↓
order_reviews

orders
↓
order_payments

order_items
↓
sellers

---

## 分析上の注意点

* order_items は orders と1対多の関係である
* order_payments は orders と1対多の関係である
* order_reviews はレビュー欠損が存在する
* 分析用テーブル作成時は order_items と order_payments を集約してから結合する必要がある
* review_score を目的変数として利用できる可能性がある
