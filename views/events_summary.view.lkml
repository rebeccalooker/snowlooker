view: events_summary {
  derived_table: {
    sql: SELECT session_id, city, state, zip, country, latitude, longitude, traffic_source, max(user_id) as user_id, browser, ip_address, os
              , coalesce(MAX(CASE WHEN event_type = 'Category' THEN 'Yes' ELSE NULL END),'No') as category_touched
              , coalesce(MAX(CASE WHEN event_type = 'Home' THEN 'Yes' ELSE NULL END),'No') as home_touched
              , coalesce(MAX(CASE WHEN event_type = 'Cart' THEN 'Yes' ELSE NULL END),'No') as cart_touched
              , coalesce(MAX(CASE WHEN event_type = 'Register' THEN 'Yes' ELSE NULL END),'No') as register_touched
              , coalesce(MAX(CASE WHEN event_type = 'Cancel' THEN 'Yes' ELSE NULL END),'No') as cancel_touched
              , coalesce(MAX(CASE WHEN event_type = 'Brand' THEN 'Yes' ELSE NULL END),'No') as brand_touched
              , coalesce(MAX(CASE WHEN event_type = 'History' THEN 'Yes' ELSE NULL END),'No') as history_touched
              , coalesce(MAX(CASE WHEN event_type = 'Product' THEN 'Yes' ELSE NULL END),'No') as product_touched
              , coalesce(MAX(CASE WHEN event_type = 'Purchase' THEN 'Yes' ELSE NULL END),'No') as purchase_touched
              , MIN(created_at) as session_start
              , MAX(created_at) as session_end
              , MAX(CASE WHEN event_type = 'Purchase' THEN created_at ELSE NULL END) as purchase_date
              , count(*) as count_of_webpages_renders
              FROM public.events
              GROUP BY 1,2,3,4,5,6,7,8,10,11,12
               ;;
#     distribution_style: all
    datagroup_trigger: adam_minton_case_study_default_datagroup
    publish_as_db_view: yes
  }

  measure: count_of_sessions {
    type: count_distinct
    sql: ${session_id} ;;
    drill_fields: [detail*]
  }

  measure: bounce_rate {
    type: number
    description: "Percentage of single page sessions / all sessions"
    sql: CAST(SUM(CASE WHEN ${count_of_webpages_renders} = 1 THEN 1 ELSE 0 END) as decimal) / cast(${count_of_sessions} as decimal) ;;
    value_format_name: percent_0
  }

  measure: conversion_rate {
    type: number
    description: "Percentage of purchase sessions / all sessions"
    sql:Cast(SUM(CASE WHEN ${purchase_touched} = 'Yes' THEN 1 ELSE 0 END) as decimal) / Cast(${count_of_sessions} as decimal) ;;
    value_format_name: percent_2
  }

  dimension: session_duration_in_minutes {
    type: number
    description: "Duration of the session in minutes between when the session started and ended"
    sql: datediff(minute,${session_start_raw}, ${session_end_raw}) ;;
  }

  measure: average_session_duration_in_minutes {
    type: average
    description: "Average session duration in minutes by customers"
    sql: ${session_duration_in_minutes} ;;
  }

  dimension: session_id {
    type: string
    primary_key: yes
    description: "Session identifier"
    sql: ${TABLE}.session_id ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: zip {
    type: string
    sql: ${TABLE}.zip ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: browser {
    type: string
    sql: ${TABLE}.browser ;;
  }

  dimension: ip_address {
    type: string
    sql: ${TABLE}.ip_address ;;
  }

  dimension: os {
    type: string
    sql: ${TABLE}.os ;;
  }

  dimension: category_touched {
    type: string
    sql: ${TABLE}.category_touched ;;
  }

  dimension: home_touched {
    type: string
    sql: ${TABLE}.home_touched ;;
  }

  dimension: cart_touched {
    type: string
    sql: ${TABLE}.cart_touched ;;
  }

  dimension: register_touched {
    type: string
    sql: ${TABLE}.register_touched ;;
  }

  dimension: cancel_touched {
    type: string
    sql: ${TABLE}.cancel_touched ;;
  }

  dimension: brand_touched {
    type: string
    sql: ${TABLE}.brand_touched ;;
  }

  dimension: history_touched {
    type: string
    sql: ${TABLE}.history_touched ;;
  }

  dimension: product_touched {
    type: string
    sql: ${TABLE}.product_touched ;;
  }

  dimension: purchase_touched {
    type: string
    sql: ${TABLE}.purchase_touched ;;
  }

  dimension_group: session_start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.session_start ;;
  }

  dimension_group: session_end {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.session_end ;;
  }

  dimension_group: purchase {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.purchase_date ;;
  }

  dimension: count_of_webpages_renders {
    type: number
    description: "The count of webpage renders within each session"
    sql: ${TABLE}.count_of_webpages_renders ;;
  }

  dimension: location {
    type: location
    sql_latitude: ${TABLE}.latitude ;;
    sql_longitude: ${TABLE}.longitude ;;
  }

  parameter: website_metric_picker {
    description: "Use with the Dynamic Website Metric measure"
    type: string
    allowed_value: {
      label: "Bounce Rate"
      value: "bounce_rate"
    }
    allowed_value: {
      label: "Sessions Count"
      value: "sessions_count"
    }
    allowed_value: {
      label: "Conversion Rate"
      value: "conversion_rate"
    }
  }

  measure: dynamic_website_metric {
    description: "Use with the Website Metric Picker to change the metric displayed"
    type: number
    label: "{% parameter website_metric_picker %} Won AOV"
    #label_from_parameter: website_metric_picker
    sql:
    CASE
    WHEN {% parameter website_metric_picker %} = 'bounce_rate' THEN
    ${bounce_rate} * 100
    WHEN {% parameter website_metric_picker %} = 'sessions_count' THEN
    ${count_of_sessions}
    WHEN {% parameter website_metric_picker %} = 'conversion_rate' THEN
    ${conversion_rate} * 100
    ELSE
    NULL
    END ;;

    }

    set: detail {
      fields: [
        session_id,
        city,
        state,
        zip,
        country,
        latitude,
        longitude,
        traffic_source,
        customer_id,
        browser,
        ip_address,
        os,
        category_touched,
        home_touched,
        cart_touched,
        register_touched,
        cancel_touched,
        brand_touched,
        history_touched,
        product_touched,
        purchase_touched,
        session_start_time,
        session_end_time,
        count_of_webpages_renders,
        location
      ]
    }
  }
