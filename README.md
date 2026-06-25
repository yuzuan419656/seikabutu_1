# Olist Review Analysis

## 概要

ブラジルのECサイト Olist の注文・レビュー情報を用いて、レビュー低評価（レビュー1〜2）の発生要因分析および予測モデルの構築を行った。

EDA（探索的データ分析）、機械学習モデル、SHAPによる解釈性分析を実施し、低評価レビューにつながる要因を特定した。

---

## 分析目的

ECサイト運営においてレビュー評価は顧客満足度の重要な指標である。

本分析では、

* どのような要因が低評価レビューにつながるのか
* 事業者が改善可能な要因は何か

を明らかにすることを目的とした。

---

## 使用データ

Olist E-commerce Dataset

分析単位：1注文 = 1レコード

### データ概要

| 項目    |      値 |
| ----- | -----: |
| レコード数 | 99,441 |
| カラム数  |     15 |

---

## 使用技術

### SQL

* BigQuery
* 集計テーブル作成
* 特徴量テーブル作成

### Python

* Pandas
* NumPy
* Matplotlib
* Seaborn
* Scikit-learn
* XGBoost
* SHAP

---

## 分析フロー

### Step1 Data Quality Check

* 欠損値確認
* 注文ステータス確認
* レビュー分布確認

成果物

* docs/data_quality_policy.md

---

### Step2 EDA

以下の仮説を検証した。

* 配送遅延が大きいほど低評価になりやすい
* 送料が高いほど低評価になりやすい
* 商品カテゴリによって低評価率が異なる
* 地域によって低評価率が異なる

成果物

* docs/eda_summary.md

---

### Step3 Feature Engineering

購入時点で利用可能な情報を中心に特徴量を作成。

主な特徴量

* item_count
* total_price
* total_freight
* total_payment
* purchase_weekday
* purchase_hour
* customer_state
* payment_type
* main_category
* freight_ratio

---

### Step4 Modeling

実施モデル

* Logistic Regression
* Random Forest
* XGBoost

評価指標

* Accuracy
* Precision
* Recall
* F1-score
* ROC-AUC

成果物

* docs/modeling_summary.md

---

### Step5 Explainability

SHAPを利用して予測要因を解釈した。

重要特徴量

1. delay_days
2. delivery_days
3. item_count
4. total_freight
5. total_payment

---

### Step6 Business Recommendation

分析結果をもとに改善施策を提案。

主な提言

* 配送品質の監視・改善
* 多商品注文の品質管理強化
* 高送料商品の顧客体験改善
* 高リスクカテゴリの重点分析

成果物

* docs/business_recommendation.md

---

## 主な分析結果

### EDA

低評価注文と高評価注文を比較した結果

| 指標     |   高評価 |   低評価 |
| ------ | ----: | ----: |
| 配送日数   | 10.9日 | 19.7日 |
| 配送遅延日数 | 0.23日 | 3.91日 |
| 送料     |  22.0 |  27.7 |

配送品質と送料が低評価と強く関連していることが確認された。

---

### モデル分析

Random Forest および XGBoost により、配送関連特徴量の重要度が高いことを確認した。

また SHAP 分析により、

* 配送遅延
* 配送日数
* 商品数
* 送料

が低評価リスクを高める要因であることが確認された。

---

## ディレクトリ構成

```text
.
├── notebooks
│   ├── 01_data_quality.ipynb
│   ├── 02_eda.ipynb
│   └── 03_modeling.ipynb
│
├── docs
│   ├── data_quality_policy.md
│   ├── eda_summary.md
│   ├── modeling_summary.md
│   └── business_recommendation.md
│
└── README.md
```

---

## 学んだこと

* EDAと予測モデルでは利用できる特徴量が異なる
* Accuracyだけでは不均衡データを適切に評価できない
* SHAPを利用することでモデルの判断根拠を説明できる
* データ分析では「精度向上」だけでなく「改善施策につなげること」が重要である
