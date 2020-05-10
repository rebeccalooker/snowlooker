view: order_items {
# Option 1 - Explicit Table Names (current state)
  sql_table_name: public.order_items ;;
# Option 2 - User attribute that is injected into the table name or schema name
  #sql_table_name: public.{{ _user_attributes['am_security_demo_department'] }}_order_items ;;
# Option 3 - User attribute that is conditional based on user attribute to select the table
  #sql_table_name: {% if _user_attributes['am_security_demo_department'] == 'admin' %} public.admin_order_items {% else  %} public.order_items {% endif %};;
##############BASE TABLE DIMENSIONS##############
#Dimensions available directly on the underlying table, no transformations

  dimension: id {
    primary_key: yes
    description: "Auto generated ID on table: order_items"
    hidden:  yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: order_id {
    description: "Customer's Order ID"
    label: "Order ID"
    type:  number
    sql:  ${TABLE}.ORDER_ID ;;
  }

  dimension_group: purchased {
    type: time
    description: "Date/Time when customer's order was placed (same as Inventory Item's Sold Date)"
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

  dimension_group: delivered {
    type: time
    description: "Date/Time when customer's order was delivered"
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
    sql: ${TABLE}.DELIVERED_AT ;;
  }

  dimension: inventory_item_id {
    type: number
    description: "Unique identifier of inventory item (a product can have multiple IDs)"
    hidden:  yes
    sql: ${TABLE}.INVENTORY_ITEM_ID ;;
  }

  dimension_group: returned {
    type: time
    description: "Date/Time when the order was returned"
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
    sql: ${TABLE}.RETURNED_AT ;;
  }

  dimension: sale_price {
    type: number
    description: "Price at which item was sold"
    value_format_name: "usd"
    sql: ${TABLE}.SALE_PRICE ;;
  }

  dimension_group: shipped {
    type: time
    description: "Date/Time item was shipped"
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
    sql: ${TABLE}.SHIPPED_AT ;;
  }

  dimension: status {
    type: string
    description: "Current status of the order (Processing, Shipped, Complete, Returned, or Cancelled)"
    sql: ${TABLE}.STATUS ;;
  }

  dimension: status_new {
    description: "Status with a blank value see impact on column charts"
    type: string
    sql: case when ${status} = 'Shipped' then '' else ${status} end ;;
  }

  dimension: customer_id {
    type: number
    description: "Unique identifier of a customer"
    hidden: yes
    sql: ${TABLE}.USER_ID ;;
  }

##############DERIVED DIMENSIONS/FILTERS##############
#Dimensions that utilize other data transformations or contain business logic

  filter: date_filter {
    type: date
    description: "Utilize with Dynamic Total Sale Price to determine period of analysis"
    default_value: "yesterday"
  }

  dimension: check_purchased_date_with_date_filter {
    type: yesno
    hidden: yes
    description: "Utilizes the dynamic date filter to determine relationship to purchase date"
    sql:
    {% condition date_filter %} ${purchased_date} {% endcondition %}
    ;;
  }

  dimension: is_completed_sale {
    type: yesno
    hidden:  yes
    description: "Determines if an order is completed (Complete, Shipped, Processing) or not (Cancelled, Returned)"
    sql: ${status} in ('Complete', 'Shipped', 'Processing') ;;
  }

  dimension_group: since_purchase {
    type: duration
    sql_start: ${purchased_date} ;;
    sql_end: current_date ;;
    intervals: [year, month, week, day]
  }

  dimension_group: between_customer_creation_and_purchase_date {
    type: duration
    sql_start: ${customers.created_date} ;;
    sql_end: ${purchased_date}  ;;
    intervals: [year, month, week, day]
  }

  dimension: days_since_last_purchase {
    type: number
    sql: ${purchased_date}-current_date ;;
  }

  dimension_group: between_purchase_date_and_delivery_date {
    type: duration
    sql_start: ${purchased_raw} ;;
    sql_end: ${delivered_raw}  ;;
    intervals: [year, month, week, day]
  }

##############MEASURES##############
#Measures that utilize aggregates for creating KPIs, charts, etc.

  measure: count_of_order_items {
    type: count
    description: "Count of order items"
    drill_fields: [order_details_drill*]
  }

  measure: count_of_orders {
    type: count_distinct
    description: "Count of orders"
    sql: ${order_id} ;;
    link: {
      label: "testing"
      url: "{{link}}&qid=QivTnmJDGDcmXiO66OE5Fx"

    }

    drill_fields: [order_details_drill*]
  }

  measure: percent_of_change_in_order_count {
    type: percent_of_previous
    description: "Count of orders"
    value_format_name:  percent_0
    sql: ${count_of_orders} ;;
    html: {% if value < 0 %}
          <p style="color: red;"> <a href: {{rendered_value}} </a> </p>
          {% else %}
          <p style="color: green;"> <a href: {{rendered_value}} </a> </p>
          {% endif %}
          ;;
  }

#{% if value < 0 %}<p style=\"color:red; \">({{rendered_value}}){% else %} {{rendered_value}} {% endif %} ;;


  measure: total_sale_price {
    type: sum
    description: "Total sales from items sold"
    sql: ${sale_price} ;;
    value_format_name: "usd"
    drill_fields: [order_details_drill*]
  }

  measure: average_sale_price {
    type:  average
    description: "Average sale price of items sold"
    sql:  ${sale_price} ;;
    value_format_name: "usd"
    drill_fields: [order_details_drill*]
  }

  measure: average_gross_revenue {
    type: average
    description: "Average revenue from completed sales (cancelled and returned orders excluded)"
    sql: ${sale_price} ;;
    value_format_name: "usd"
    filters: {
      field: is_completed_sale
      value: "yes"
    }
    drill_fields: [order_details_drill*]
  }

  measure: cumulative_total_sales {
    type: running_total
    description: "Cumulative total sales from items sold"
    sql:  ${total_sale_price} ;;
    value_format_name: "usd"
    drill_fields: [order_details_drill*]
  }

  measure: total_gross_revenue {
    type: sum
    description: "Total revenue from completed sales (cancelled and returned orders excluded)"
    sql: ${sale_price} ;;
    value_format_name: "usd"
    filters: {
      field: is_completed_sale
      value: "yes"
    }
    drill_fields: [order_details_drill*]
  }

  measure: total_gross_cost {
    type: sum
    description: "Total cost from completed sales (cancelled and returned orders excluded)"
    sql: ${inventory_items.item_cost} ;;
    value_format_name: "usd"
    filters: {
      field: is_completed_sale
      value: "yes"
    }
    drill_fields: [order_details_drill*]
  }

  measure: total_cost {
    type: sum
    description: "Total cost of items sold from inventory"
    sql: ${inventory_items.item_cost} ;;
    value_format_name: "usd"
    drill_fields: [order_details_drill*]
  }

  measure: average_cost {
    type: average
    description: "Average cost of items sold from inventory"
    sql: ${inventory_items.item_cost} ;;
    value_format_name: "usd"
    drill_fields: [order_details_drill*]
  }

  measure: total_gross_margin_amount {
    type: number
    description: "Total difference between the total revenue from completed sales and the cost of the goods that were sold"
    sql:  ${total_gross_revenue} - ${total_gross_cost};;
    value_format_name: "usd"
    drill_fields: [order_details_drill*]
  }

#  measure: total_gross_revenue_percentage {
#    type: number
#    description: "Total difference between the total revenue from completed sales and the cost of the goods that were sold"
#    sql:  ${total_gross_revenue};;
#    value_format_name: "usd"
#    drill_fields: [order_details_drill*]
#  }

  measure: average_gross_margin_amount {
    type: average
    description: "Average difference between the total revenue from completed sales and the cost of the goods that were sold"
    sql: ${sale_price} - ${inventory_items.item_cost};;
    filters: {
      field: is_completed_sale
      value: "yes"
    }
    value_format_name: "usd"
    drill_fields: [order_details_drill*]

    link: {
      label: "Explore brands and categories"
      url: "
      {% assign vis_config = '{
      \"stacking\" : \"normal\",
      \"legend_position\" : \"center\",
      \"x_axis_gridlines\" : false,
      \"y_axis_gridlines\" : true,
      \"show_view_names\" : false,
      \"y_axis_combined\" : true,
      \"show_y_axis_labels\" : true,
      \"show_y_axis_ticks\" : true,
      \"y_axis_tick_density\" : \"default\",
      \"show_x_axis_label\" : true,
      \"show_x_axis_ticks\" : true,
      \"show_null_points\" : false,
      \"interpolation\" : \"monotone\",
      \"type\" : \"looker_column\",
      \"totals_color\": [
      \"#808080\"
      ],
      \"x_axis_label\" : \"Category\"
      }' %}
      {{ link }}&vis_config={{ vis_config | encode_uri }}&sorts=products.category+asc+asc&pivots=products.brand&fields=products.category,products.brand,order_items.average_gross_margin_amount&toggle=dat,pik,vis&limit=5000"
    }

  }

  measure: gross_margin_percentage {
    type: number
    description: "Total Gross Margin Amount / Total Gross Revenue"
    sql: ${total_gross_margin_amount} / ${total_gross_revenue} ;;
    value_format_name: "percent_2"
    drill_fields: [order_details_drill*]
  }

  measure: number_of_items_returned {
    type:  count
    description: "Number of items that were returned by dissatisfied customers"
    filters: {
      field: returned_date
      value: "NOT NULL"
    }
    value_format_name: "decimal_0"
    drill_fields: [order_details_drill*]
  }

  measure: item_return_rate {
    type: number
    description: "Number of Items Returned / Count of Order Items"
    sql: (1.0 * ${number_of_items_returned}) / (1.0 * ${count_of_order_items}) ;;
    value_format_name: "percent_2"
    drill_fields: [order_details_drill*]
  }

  measure: number_of_customers_returning_items {
    type: count
    description: "Number of distinct customers who have returned an item at some point"
    filters: {
      field: returned_date
      value: "NOT NULL"
    }
    value_format_name: "decimal_0"
    drill_fields: [order_details_drill*]
  }

  measure: number_of_customers_made_who_purchases {
    type: count
    description: "Number of distinct customers who have made a purchase"
    drill_fields: [order_details_drill*]
  }

  measure: percent_of_users_with_returns {
    type: number
    description: "Number of Customer Returning Items / Number of Customers Who Made Purchases"
    sql: ${number_of_customers_returning_items} / ${number_of_customers_made_who_purchases};;
    value_format_name: "percent_2"
    drill_fields: [order_details_drill*]
  }

  measure: average_spend_per_customer {
    type: number
    description: "Total Sale Price / total number of customers"
    sql:${total_sale_price} / ${number_of_customers_made_who_purchases} ;;
    value_format_name: "usd"
    drill_fields: [order_details_drill*]
    link: {
      label: "{% if customers.traffic_source._in_query == true and customers.new_customer_indicator._in_query == true %} Explore further into age tier and gender {% endif %}"
      # label will only appear when traffic source and new customer indicator are explicitly displayed
      # url utilizes max_traffic_source to provide the traffic source
      url: "https://profservices.dev.looker.com/dashboards/4NtclBN4WOLPaAH4qWReT6?New%20Customer%20Indicator={{ max_customer_indicator._value }}&Traffic%20Source={{ max_traffic_source._value }}" #use kevin's row logic to avoid forced select statement in backend but doesn't appear in front end
      # url: "https://profservices.dev.looker.com/dashboards/4NtclBN4WOLPaAH4qWReT6?New%20Customer%20Indicator={{ customers.new_customer_indicator._value] }}&Traffic%20Source={{ customers.traffic_source._value }}"
      # use kevin's row logic to avoid forced select statement in backend but doesn't appear in front end
      # huge amount of kevin help on this
      # caveat anytime this metric is used it will automatically pull in max_traffic_source as it allows
    }

  }

  measure: max_customer_indicator {
    type: string
    hidden: yes
    description: "This field is a workaround for bringing over the link on average_spend_per_customer to the Customer Dashboard"
    sql:MAX(CASE WHEN ${customers.new_customer_indicator} THEN 'Yes' ELSE 'No' END) ;;
  }


  measure: max_traffic_source {
    type: string
    hidden: yes
    description: "This field is a workaround for bringing over the link on average_spend_per_customer to the Customer Dashboard"
    sql:MAX(${customers.traffic_source}) ;;
  }

  measure: dynamic_total_revenue {
    type: sum
    sql: ${sale_price} ;;
    description: "Utilize with Date Filter to determine period of analysis"
    filters: {
      field: check_purchased_date_with_date_filter
      value: "yes"
    }
    value_format_name: "usd"
    drill_fields: [order_details_drill*]
  }

  measure: first_order {
    type: date_raw
    sql: MIN(${purchased_raw}) ;;
    description: "First order date"
  }

  measure: latest_order {
    type: date_raw
    sql: MAX(${purchased_raw}) ;;
    description: "Latest order date"
  }

  measure: days_since_lastest_order {
    type: number
    sql:  datediff(days,${latest_order},getdate());;
    description: "Number of days since the latest order placed"
  }

  measure: is_customer_active {
    hidden: yes
    type: yesno
    sql: ${days_since_lastest_order} <= 90 ;;
    description: "If the customer order in the last 90 days then Yes they are active"
  }

  measure: is_customer_repeat {
    hidden: yes
    type: yesno
    sql: ${count_of_orders} > 1  ;;
    description: "If the customer placed more than 1 order then Yes they are a repeat customer"
  }

  measure: cumulative_gross_revenue {
    type: running_total
    sql: ${total_gross_revenue} ;;
  }

  measure: purchases_made_in_past_60_days {
    type: count
    filters: {
      field: days_since_last_purchase
      value: "<= 60"
    }
  }

##############DRILL SET##############
#Default drill set for measures

  set: order_details_drill {
    fields: [
      order_id,
      status,
      purchased_date,
      shipped_date,
      delivered_date,
      products.sku,
      products.department,
      products.category,
      products.brand,
      products.name,
      products.item_cost,
      sale_price,
      customers.customer_id,
      customers.name,
      customers.age_tier,
      customers.gender,
      customers.city,
      customers.state,
      customers.traffic_source,
      customers.created_date
    ]
  }


  filter: current_period {
    type: date
  }

  filter: previous_period {
    type: date
  }

  dimension: is_order_date_in_current_period {
    type: yesno
    sql: {% condition current_period %} ${purchased_date} {% endcondition %} ;;
  }

  dimension: is_order_date_in_previous_period {
    type: yesno
    sql: {% condition previous_period %} ${purchased_date} {% endcondition %} ;;
  }

  measure: count_of_orders_in_current_period {
    type: count
    filters: [is_order_date_in_current_period: "Yes"]
  }

  measure: count_of_orders_in_previous_period {
    type: count
    filters: [is_order_date_in_previous_period: "Yes"]
  }

}
