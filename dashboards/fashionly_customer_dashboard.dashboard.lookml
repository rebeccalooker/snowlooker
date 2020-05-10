- dashboard: fashion_ly_customer_dashboard
  title: Fashion.ly Customer Dashboard
  layout: newspaper
  elements:
  - title: Gender Average Spend
    name: Gender Average Spend
    model: rebecca_snowlooker
    explore: order_items
    type: looker_column
    fields: [customers.gender, order_items.average_spend_per_customer]
    sorts: [order_items.average_spend_per_customer desc]
    limit: 500
    column_limit: 50
    query_timezone: user_timezone
    listen:
      New Customer Indicator: customers.new_customer_indicator
      Traffic Source: customers.traffic_source
    row: 2
    col: 1
    width: 11
    height: 6
  - title: Age Tier Average Spend
    name: Age Tier Average Spend
    model: rebecca_snowlooker
    explore: order_items
    type: looker_column
    fields: [customers.age_tier, order_items.average_spend_per_customer]
    fill_fields: [customers.age_tier]
    sorts: [customers.age_tier]
    limit: 500
    query_timezone: user_timezone
    listen:
      New Customer Indicator: customers.new_customer_indicator
      Traffic Source: customers.traffic_source
    row: 2
    col: 12
    width: 11
    height: 6
  - title: Average Customer Spend (by Source and New/Existing Customer)
    name: Average Customer Spend (by Source and New/Existing Customer)
    model: rebecca_snowlooker
    explore: order_items
    type: single_value
    fields: [customers.traffic_source, customers.new_customer_indicator, order_items.average_spend_per_customer]
    sorts: [order_items.average_spend_per_customer desc]
    limit: 500
    query_timezone: user_timezone
    series_types: {}
    listen:
      New Customer Indicator: customers.new_customer_indicator
      Traffic Source: customers.traffic_source
    row: 0
    col: 1
    width: 22
    height: 2
  - name: Revenue Source Comparison
    title: Revenue Source Comparison
    model: rebecca_snowlooker
    explore: order_items
    type: looker_column
    fields: [customers.traffic_source, customers.new_customer_indicator, order_items.average_spend_per_customer]
    pivots: [customers.traffic_source]
    fill_fields: [customers.new_customer_indicator]
    sorts: [customers.new_customer_indicator, customers.traffic_source]
    limit: 500
    query_timezone: America/New_York
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    hidden_series: []
    hide_legend: false
    legend_position: center
    series_types: {}
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_dropoff: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: []
    row: 8
    col: 1
    width: 22
    height: 6
  filters:
  - name: New Customer Indicator
    title: New Customer Indicator
    type: field_filter
    default_value: 'Yes'
    allow_multiple_values: true
    required: false
    model: rebecca_snowlooker
    explore: order_items
    listens_to_filters: []
    field: customers.new_customer_indicator
  - name: Traffic Source
    title: Traffic Source
    type: field_filter
    default_value: Display
    allow_multiple_values: true
    required: false
    model: rebecca_snowlooker
    explore: order_items
    listens_to_filters: []
    field: customers.traffic_source
