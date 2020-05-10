view: customer_order_metrics {

#There are 2 ways to create derived tables, through sql or lookml
  derived_table: {
    explore_source: customers {
      column: customer_id { field: customers.customer_id }
      column: lifetime_orders { field: order_items.count_of_orders }
      column: lifetime_gross_revenue { field: order_items.total_gross_revenue }
      column: lifetime_average_gross_revenue { field: order_items.average_gross_revenue }
      column: first_order { field: order_items.first_order }
      column: latest_order { field: order_items.latest_order }
      column: is_customer_active { field: order_items.is_customer_active }
      column: days_since_lastest_order { field: order_items.days_since_lastest_order }
      column: is_customer_repeat { field: order_items.is_customer_repeat }
    }
#     distribution_style: all
    datagroup_trigger: adam_minton_case_study_default_datagroup
  }

  dimension: customer_id {
    hidden:  yes
    primary_key: yes
    description: "Unique identifier of a customer"
    type: number
  }

  dimension: lifetime_orders {
    hidden: yes
    description: "Count of a customer's lifetime orders"
    type: number
  }

  dimension: lifetime_gross_revenue {
    hidden:  yes
    description: "Total revenue from completed sales (cancelled and returned orders excluded)"
    value_format_name: "usd"
    type: number
  }

  dimension: lifetime_average_gross_revenue {
    hidden:  yes
    description: "Average revenue from completed sales (cancelled and returned orders excluded)"
    value_format_name: "usd"
    type: number
  }

  dimension_group: first_order {
    type: time
    description: "First order date"
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
  }

  dimension_group: latest_order {
    type: time
    description: "Latest order date"
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
  }

  dimension: is_customer_active {
    description: "If the customer order in the last 90 days then Yes they are active"
    hidden: yes
    type: yesno
  }

  dimension: days_since_lastest_order {
    description: "Number of days since the latest order placed"
    type: number
  }

  dimension: is_customer_repeat {
    description: "If the customer placed more than 1 order then Yes they are a repeat customer"
    type: yesno
  }

  dimension: type_of_customer {
    type: string
    description: "Determines if customer is unengaged (no orders), inactive (latest order is more than 90 days old), or active."
    sql: CASE WHEN ${is_customer_active} is null THEN 'Unengaged' WHEN ${is_customer_active} = 'No' THEN 'Inactive' ELSE 'Active' END;;
  }

  dimension: lifetime_order_tier {
    type: tier
    description: "6 common order tiers"
    tiers: [1,2, 3, 6, 10]
    style: integer
    sql: ${lifetime_orders} ;;
  }

  dimension: lifetime_revenue_tier {
    type: tier
    description: "7 common revenue tiers"
    tiers: [5,20,50,100,500,1000]
    style: relational
    sql: ${lifetime_gross_revenue} ;;
    value_format_name: "usd"
  }

  measure: sum_of_lifetime_orders  {
    description: "Sum of lifetime orders"
    type: sum
    sql: ${lifetime_orders} ;;
  }

  measure: sum_of_lifetime_gross_revenue {
    description: "Sum of Total revenue from completed sales (cancelled and returned orders excluded)"
    value_format_name: "usd"
    type: sum
    sql: ${lifetime_gross_revenue} ;;
  }

  measure: average_of_lifetime_gross_revenue {
    description: "Average of Total revenue from completed sales (cancelled and returned orders excluded)"
    value_format_name: "usd"
    type: average
    sql: ${lifetime_gross_revenue} ;;
  }

  measure: average_number_of_orders {
    description: "Average number of orders"
    value_format_name: decimal_0
    type: average
    sql: ${lifetime_orders} ;;
  }


#########DERIVED TABLE BASED ON SQL#############
  #sql: SELECT user_id
  #  , COUNT(distinct order_id) as customer_lifetime_orders
  #  , SUM(CASE WHEN status in ('Complete', 'Shipped', 'Processing') THEN sale_price ELSE 0 END) as customer_lifetime_revenue
  #  , AVG(CASE WHEN status in ('Complete', 'Shipped', 'Processing') THEN sale_price ELSE 0 END) as average_customer_lifetime_revenue
  #  , MIN(created_at) as first_order_date
  #  , MAX(created_at) as lastest_order_date
  #  , CASE WHEN lastest_order_date >= current_date - 90 THEN 'Yes' ELSE 'No' END as is_customer_active
  #  , datediff(day,lastest_order_date,current_date) as days_since_lastest_order
  #  , CASE WHEN customer_lifetime_orders > 1 THEN 'Yes' ELSE 'No' END as is_repeat_customer
  #FROM public.order_items
  #GROUP BY user_id
  # ;;

#     dimension: user_id {
#       type: number
#       sql: ${TABLE}.user_id ;;
#       primary_key: yes
#     }
#
#     dimension: customer_lifetime_orders {
#       type: number
#       sql: ${TABLE}.customer_lifetime_orders ;;
#     }
#
#     dimension: customer_lifetime_revenue {
#       type: number
#       sql: ${TABLE}.customer_lifetime_revenue ;;
#     }
#
#     dimension: average_customer_lifetime_revenue {
#       type: number
#       sql: ${TABLE}.average_customer_lifetime_revenue ;;
#     }
#
#     dimension_group: first_order_date {
#       type: time
#       sql: ${TABLE}.first_order_date ;;
#     }
#
#     dimension_group: lastest_order_date {
#       type: time
#       sql: ${TABLE}.lastest_order_date ;;
#     }
#
#     dimension: is_customer_active {
#       type: string
#       sql: ${TABLE}.is_customer_active ;;
#     }
#
#     dimension: days_since_lastest_order {
#       type: number
#       sql: ${TABLE}.days_since_lastest_order ;;
#     }
#
#     dimension: is_repeat_customer {
#       type: string
#       sql: ${TABLE}.is_repeat_customer ;;
#     }
#
#   measure: count {
#     type: count
#     drill_fields: [detail*]
#   }
#
#     set: detail {
#       fields: [
#         user_id,
#         customer_lifetime_orders,
#         customer_lifetime_revenue,
#         average_customer_lifetime_revenue,
#         first_order_date_time,
#         lastest_order_date_time,
#         is_customer_active,
#         days_since_lastest_order,
#         is_repeat_customer
#       ]
#     }
}
