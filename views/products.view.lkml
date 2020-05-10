view: products {
  sql_table_name: public.products ;;

  # parameter: brand_to_compare {
  #   type: string
  #   suggest_dimension: brand
  # }

##############BASE TABLE DIMENSIONS##############
#Dimensions available directly on the underlying table, no transformations

  dimension: product_id {
    primary_key: yes
    type: number
    description: "Unique identifier of Product"
    hidden: yes
    sql: ${TABLE}.ID ;;
  }

  dimension: brand {
    type: string
    #required_fields: [product_id]
    description: "Over 2000 brand names for product in inventory"
    sql: ${TABLE}.BRAND ;;
    link: {
      label: "{{ value }} Google"
      url: "http://www.google.com/search?q={{value}}"
      icon_url: "http://google.com/favicon.ico"
    }
    link: {
      label: "Facebook"
      url: "https://www.facebook.com/search/top/?q={{value}}"
      icon_url: "http://facebook.com/favicon.ico"
    }
    link: {
      label: "Link to Looker"
      url: "https://profservices.dev.looker.com/looks/463?&f[products.brand]={{value}}"
    }
    # link: {
    #   label: "Show Product ID"
    #   url: "http://www.google.com/search?q={{product_id._value}}"
    # }

    html: <a target="new" href="https://www.google.com/search?q={{value}}" alt="Click link to google">{{value}}</a>;;
  }

  dimension: category {
    type: string
    description: "26 different categories of products in inventory"
    sql: ${TABLE}.CATEGORY ;;
  }

  dimension: item_cost_courier {
    type: number
    description: "Cost of the item when purchased"
    sql: ${TABLE}.COST ;;
    html: <p style="color:blue;font-family:courier;">{{rendered_value}}</p ;;
  }

  dimension: item_cost {
    required_access_grants: [inventory]
    type: number
    description: "Cost of the item when purchased"
    sql: ${TABLE}.COST ;;
  }

  dimension: department {
    type: string
    description: "Indicates whether the product is for men or women"
    sql: ${TABLE}.DEPARTMENT ;;
  }

  dimension: distribution_center_id {
    type: number
    description: "Distribution Center where product is held"
    hidden: yes
    sql: ${TABLE}.DISTRIBUTION_CENTER_ID ;;
  }

  dimension: name {
    type: string
    description: "Name of the product"
    sql: ${TABLE}.NAME ;;
  }

  dimension: retail_price {
    type: number
    description: "Suggested retail price of the product"
    sql: ${TABLE}.RETAIL_PRICE ;;
  }

  dimension: sku {
    type: string
    description: "Unique identifier of the product"
    sql: ${TABLE}.SKU ;;
  }

##############DERIVED DIMENSIONS/FILTERS##############
#Dimensions that utilize other data transformations or contain business logic

  # dimension: brand_comparison {
  #   type: string
  #   sql: case when ${brand} = {% parameter brand_to_compare %} then ${brand}
  #         else 'All Other Brands' end ;;
  # }

##############MEASURES##############
#Measures that utilize aggregates for creating KPIs, charts, etc.

  measure: count_of_products {
    type: count
    description: "Count of products"
  }

  measure: avg_item_cost {
    type: average
    sql: ${item_cost} ;;
  }

##############DRILL SET##############
#Default drill set for measures

}
