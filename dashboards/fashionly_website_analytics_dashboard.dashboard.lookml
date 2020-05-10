- dashboard: fashion_ly_website_analytics_dashboard
  title: Fashion.ly Website Analytics Dashboard
  layout: newspaper
  elements:
  - name: Website Conversion Rate
    title: Website Conversion Rate
    model: rebecca_snowlooker
    explore: events_summary
    type: single_value
    fields: [events_summary.conversion_rate]
    limit: 500
    query_timezone: America/New_York
    series_types: {}
    listen:
      Session Start Date: events_summary.session_start_date
    row: 7
    col: 13
    width: 10
    height: 2
  - name: Website Dynamic Metric
    title: Website Dynamic Metric
    model: rebecca_snowlooker
    explore: events_summary
    type: looker_line
    fields: [events_summary.session_start_month, events_summary.dynamic_website_metric]
    fill_fields: [events_summary.session_start_month]
    filters: {}
    sorts: [events_summary.session_start_month desc]
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
    hide_legend: true
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    swap_axes: false
    show_null_points: true
    interpolation: linear
    listen:
      Metric Picker: events_summary.website_metric_picker
    row: 0
    col: 3
    width: 20
    height: 5
  - name: Website Bounce Rate
    title: Website Bounce Rate
    model: rebecca_snowlooker
    explore: events_summary
    type: single_value
    fields: [events_summary.bounce_rate]
    sorts: [events_summary.bounce_rate desc]
    limit: 500
    query_timezone: America/New_York
    series_types: {}
    listen:
      Session Start Date: events_summary.session_start_date
    row: 5
    col: 13
    width: 10
    height: 2
  - name: Website Traffic Source
    title: Website Traffic Source
    model: rebecca_snowlooker
    explore: events_summary
    type: looker_pie
    fields: [events_summary.count_of_sessions, events_summary.traffic_source]
    sorts: [events_summary.count_of_sessions desc]
    limit: 500
    query_timezone: America/New_York
    series_types: {}
    listen:
      Session Start Date: events_summary.session_start_date
    row: 5
    col: 3
    width: 10
    height: 6
  - name: Website Session Traffic
    title: Website Session Traffic
    model: rebecca_snowlooker
    explore: events_summary
    type: single_value
    fields: [events_summary.count_of_sessions]
    limit: 500
    query_timezone: America/New_York
    listen:
      Session Start Date: events_summary.session_start_date
    row: 9
    col: 13
    width: 10
    height: 2
  - title: New Tile
    name: New Tile
    model: rebecca_snowlooker
    explore: order_items
    type: looker_column
    fields: [order_items.count_of_orders, customers.gender, order_items.shipped_month]
    pivots: [customers.gender]
    fill_fields: [order_items.shipped_month]
    filters:
      customers.gender: ''
      order_items.shipped_month: 5 months
    sorts: [order_items.count_of_orders desc 0, customers.gender]
    limit: 500
    column_limit: 50
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
    trellis: pivot
    stacking: ''
    limit_displayed_rows: false
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
    series_types: {}
    row: 11
    col: 0
    width: 8
    height: 6
  filters:
  - name: Session Start Date
    title: Session Start Date
    type: date_filter
    default_value: 30 days
    allow_multiple_values: true
    required: false
  - name: Metric Picker
    title: Metric Picker
    type: field_filter
    default_value: sessions^_count
    allow_multiple_values: true
    required: false
    model: rebecca_snowlooker
    explore: events_summary
    listens_to_filters: []
    field: events_summary.website_metric_picker
