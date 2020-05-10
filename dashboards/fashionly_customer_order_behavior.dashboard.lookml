- dashboard: fashion_ly_customer_order_behavior
  title: Fashion.ly Customer Order Behavior
  layout: newspaper
  elements:
  - title: 60 Day Repeat Purchase across Events
    name: 60 Day Repeat Purchase across Events
    model: rebecca_snowlooker
    explore: order_items
    type: looker_bar
    fields: [customer_order_sequence.customer_60_day_repeat_purchase, customers.traffic_source]
    sorts: [customer_order_sequence.customer_60_day_repeat_purchase desc]
    limit: 500
    query_timezone: America/New_York
    series_types: {}
    listen: {}
    row: 0
    col: 14
    width: 10
    height: 7
  - title: Gross Revenue This Year from Repeat Customers (Yes/No)
    name: Gross Revenue This Year from Repeat Customers (Yes/No)
    model: rebecca_snowlooker
    explore: order_items
    type: looker_pie
    fields: [customer_order_metrics.is_customer_repeat, order_items.total_gross_revenue]
    fill_fields: [customer_order_metrics.is_customer_repeat]
    filters:
      order_items.purchased_date: This Year
    sorts: [customer_order_metrics.is_customer_repeat]
    limit: 500
    column_limit: 50
    series_types: {}
    listen: {}
    row: 7
    col: 14
    width: 10
    height: 6
  - title: Sequence of Top 10 Most Popular Products
    name: Sequence of Top 10 Most Popular Products
    model: rebecca_snowlooker
    explore: order_items
    type: looker_column
    fields: [products.category, customer_order_sequence.order_sequence_tier, order_items.count_of_orders]
    pivots: [customer_order_sequence.order_sequence_tier]
    fill_fields: [customer_order_sequence.order_sequence_tier]
    sorts: [customer_order_sequence.order_sequence_tier 0, order_items.count_of_orders
        desc 0]
    limit: 500
    column_limit: 50
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
    stacking: normal
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    hide_legend: true
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen: {}
    row: 7
    col: 0
    width: 14
    height: 6
  - title: Top 10 Popular 1st Products in the Past Year
    name: Top 10 Popular 1st Products in the Past Year
    model: rebecca_snowlooker
    explore: order_items
    type: looker_column
    fields: [products.category, order_items.count_of_order_items, order_items.average_gross_margin_amount]
    filters:
      customer_order_sequence.order_sequence: '1'
      order_items.purchased_date: 1 years
    sorts: [order_items.count_of_order_items desc]
    limit: 10
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: order_items.count_of_order_items,
            id: order_items.count_of_order_items, name: Count of Order Items}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: linear}, {
        label: !!null '', orientation: right, series: [{axisId: order_items.average_gross_margin_amount,
            id: order_items.average_gross_margin_amount, name: Average Gross Margin
              Amount}], showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        type: linear}]
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
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen: {}
    row: 0
    col: 0
    width: 14
    height: 7
