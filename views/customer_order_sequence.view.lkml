view: customer_order_sequence {

  derived_table:{

    sql:
       SELECT order_id, user_id,created_at
      , RANK() OVER(PARTITION BY user_id ORDER BY created_at ASC,order_id DESC) AS order_sequence
      , LAG(created_at,1) OVER (PARTITION BY user_id ORDER BY created_at ASC, order_id DESC) AS previous_purchase_date
      , RANK() OVER(PARTITION BY user_id ORDER BY created_at DESC,order_id ASC) AS order_sequence_reverse
      FROM public.order_items;;

    }

    dimension: order_id {
      type: number
      sql: ${TABLE}.order_id ;;
      primary_key: yes
      hidden: yes
    }

    dimension: user_id {
      type: number
      sql: ${TABLE}.user_id ;;
      hidden: yes
    }

    dimension_group: purchased {
      type: time
      description: "Date/Time when customer's order was placed for prior order"
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
      sql: ${TABLE}.created_at ;;
      hidden:  yes
    }

    dimension: order_sequence {
      type: number
      sql: ${TABLE}.order_sequence ;;
    }

    dimension: order_sequence_tier {
      type: tier
      sql: ${TABLE}.order_sequence ;;
      tiers: [0, 1, 2, 3, 4, 5, 10, 20, 30]
      style: integer

    }

    dimension: order_sequence_reverse {
      type: number
      sql: ${TABLE}.order_sequence_reverse ;;
      hidden: yes
    }

    dimension_group: previous_purchased {
      type: time
      description: "Date/Time when customer's order was placed for prior order"
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
      sql: ${TABLE}.previous_purchase_date ;;
    }

    dimension: days_between_orders{
      type: duration_day
      sql_start: ${previous_purchased_raw} ;;
      sql_end: ${purchased_raw};;
    }

    measure: average_duration_between_orders {
      type: average
      sql: ${days_between_orders} ;;
    }

    dimension: is_first_purchase {
      type: yesno
      sql: ${order_sequence} = 1 ;;
    }

    dimension: has_subsequent_orders {
      type: yesno
      sql: ${order_sequence} <> ${order_sequence_reverse} ;;
      hidden: yes
      #is_customer_repeat provides same result
    }

    dimension: order_repurchase_60_days {
      type: yesno
      sql: ${days_between_orders} <= 90 ;;
      hidden: yes
    }

    measure: unique_customer_orders_repurchase_60_days {
      type: count_distinct
      sql: ${user_id} ;;
      hidden: yes
      filters: {
        field: order_repurchase_60_days
        value: "Yes"
      }
    }

    measure: unique_customer_count {
      type: count_distinct
      sql: ${user_id} ;;
      hidden: yes
    }

    measure: customer_60_day_repeat_purchase {
      type: number
      sql: 1.0* ${unique_customer_orders_repurchase_60_days} / nullif(${unique_customer_count},0.0) ;;
      value_format_name: percent_0
    }

  }
