view: inventory_items {
  sql_table_name: public.inventory_items ;;

##############BASE TABLE DIMENSIONS##############
#Dimensions available directly on the underlying table, no transformations

  dimension: inventory_item_id {
    primary_key: yes
    type: number
    description: "Unique identifier of inventory item (a product can have multiple IDs)"
    label: "Inventory Item ID"
    sql: ${TABLE}.ID ;;
  }

  dimension: item_cost {
    type: number
    description: "Cost of the item when purchased"
    hidden:  yes
    sql: ${TABLE}.COST ;;
  }

  dimension_group: stock {
    type: time
    description: "Date/Time the item was stocked into inventory"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      month_name,
      quarter,
      quarter_of_year,
      year
    ]
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: product_brand {
    description: "Over 2000 brand names for product in inventory"
    hidden: yes
    type: string
    sql: ${TABLE}.PRODUCT_BRAND ;;
  }

  dimension: product_category {
    description: "26 different categories of products in inventory"
    hidden:  yes
    type: string
    sql: ${TABLE}.PRODUCT_CATEGORY ;;
  }

  dimension: product_department {
    description: "Indicates whether the product is for men or women"
    hidden:  yes
    type: string
    sql: ${TABLE}.PRODUCT_DEPARTMENT ;;
  }

  dimension: product_distribution_center_id {
    description: "Distribution Center where product is held"
    hidden: yes
    type: number
    sql: ${TABLE}.PRODUCT_DISTRIBUTION_CENTER_ID ;;
  }

  dimension: product_id {
    type: number
    hidden:  yes
    description: "Unique identifer of the product"
    # hidden: yes
    sql: ${TABLE}.PRODUCT_ID ;;
  }

  dimension: product_name {
    type: string
    hidden:  yes
    description: "Name of the product"
    sql: ${TABLE}.PRODUCT_NAME ;;
  }

  dimension: product_retail_price {
    type: number
    hidden: yes
    description: "Intended retail price of the product"
    sql: ${TABLE}.PRODUCT_RETAIL_PRICE ;;
  }

  dimension: product_sku {
    type: string
    hidden:  yes
    description: "Unique identifier of the product"
    sql: ${TABLE}.PRODUCT_SKU ;;
  }

  dimension_group: sold {
    type: time
    description: "Date/Time when item was sold (same as Order Item's Purchased Date)"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      month_name,
      quarter,
      quarter_of_year,
      year
    ]
    sql: ${TABLE}.SOLD_AT ;;
  }

##############DERIVED DIMENSIONS/FILTERS##############
#Dimensions that utilize other data transformations or contain business logic

#None


##############MEASURES##############
#Measures that utilize aggregates for creating KPIs, charts, etc.

  measure: count_of_inventory_items {
    type: count
    description: "Count of Inventory Items"
  }

##############DRILL SET##############
#Default drill set for measures

#None

}
