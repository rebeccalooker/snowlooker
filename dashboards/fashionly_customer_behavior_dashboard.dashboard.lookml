- dashboard: fashion_ly_customer_behavior_dashboard
  title: Fashion.ly Customer Behavior Dashboard
  layout: newspaper
  elements:
  - name: Customer Revenue Tier and Contribution
    title: Customer Revenue Tier and Contribution
    model: rebecca_snowlooker
    explore: customers
    type: looker_column
    fields: [customer_order_metrics.lifetime_revenue_tier, customers.count_of_customers,
      customer_order_metrics.sum_of_lifetime_gross_revenue]
    fill_fields: [customer_order_metrics.lifetime_revenue_tier]
    sorts: [customer_order_metrics.lifetime_revenue_tier]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: total_revenue, label: Total Revenue, expression: 'sum(${customer_order_metrics.sum_of_lifetime_gross_revenue})',
        value_format: !!null '', value_format_name: usd, _kind_hint: measure, _type_hint: number},
      {table_calculation: percentage_of_overall_revenue, label: Percentage of Overall
          Revenue, expression: "${customer_order_metrics.sum_of_lifetime_gross_revenue}/${total_revenue}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}, {table_calculation: running_sum_of_of_overall_revenue,
        label: Running Sum of % of Overall Revenue, expression: 'running_total(${percentage_of_overall_revenue})',
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/New_York
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: customers.count_of_customers,
            id: customers.count_of_customers, name: Count of Customers}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: linear}, {
        label: '', orientation: right, series: [{axisId: running_sum_of_of_overall_revenue,
            id: running_sum_of_of_overall_revenue, name: Running Sum of % of Overall
              Revenue}], showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
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
    hidden_series: []
    legend_position: center
    series_types:
      running_sum_of_of_overall_revenue: line
      percentage_of_overall_revenue: line
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_dropoff: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [total_revenue, customer_order_metrics.sum_of_lifetime_gross_revenue,
      percentage_of_overall_revenue]
    row: 8
    col: 12
    width: 12
    height: 6
  - name: Customer Order Distribution
    title: Customer Order Distribution
    model: rebecca_snowlooker
    explore: customers
    type: looker_column
    fields: [customers.count_of_customers, customer_order_metrics.lifetime_order_tier]
    fill_fields: [customer_order_metrics.lifetime_order_tier]
    sorts: [customer_order_metrics.lifetime_order_tier]
    limit: 500
    column_limit: 50
    query_timezone: user_timezone
    series_types: {}
    row: 8
    col: 0
    width: 12
    height: 6
  - name: New vs Old Customers Sales Makeup
    title: New vs Old Customers Sales Makeup
    model: rebecca_snowlooker
    explore: order_items
    type: looker_area
    fields: [customers.new_customer_indicator, order_items.purchased_date, order_items.total_sale_price]
    pivots: [customers.new_customer_indicator]
    fill_fields: [order_items.purchased_date, customers.new_customer_indicator]
    filters:
      order_items.purchased_date: 90 days
    sorts: [customers.new_customer_indicator 0, order_items.purchased_date]
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
    stacking: percent
    limit_displayed_rows: false
    hide_legend: false
    legend_position: center
    series_types: {}
    point_style: none
    series_colors:
      No - order_items.total_revenue: "#9fdee0"
      Yes - order_items.total_revenue: "#a9c574"
    series_labels:
      No - order_items.total_revenue: Existing Customer
      Yes - order_items.total_revenue: New Customer
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    trend_lines: [{color: "#000000", label_position: right, period: 7, regression_type: linear,
        series_index: 1, show_label: false, label_type: r2}]
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    row: 14
    col: 0
    width: 12
    height: 6
  - name: Avg Customer Spend Past 30 Days
    title: Avg Customer Spend Past 30 Days
    model: rebecca_snowlooker
    explore: order_items
    type: single_value
    fields: [order_items.average_spend_per_customer]
    filters:
      order_items.purchased_date: 30 days
    limit: 500
    query_timezone: America/New_York
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    single_value_title: Avg Cust Spend (30 days)
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: order_items.average_spend_per_customer,
            id: order_items.average_spend_per_customer, name: Average Spend per Customer}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    hide_legend: false
    legend_position: center
    series_types: {}
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    swap_axes: false
    show_null_points: true
    interpolation: linear
    row: 2
    col: 0
    width: 8
    height: 4
  - name: Avg Cust Lifetime Spend
    title: Avg Cust Lifetime Spend
    model: rebecca_snowlooker
    explore: customers
    type: single_value
    fields: [customer_order_metrics.average_of_lifetime_gross_revenue]
    sorts: [customer_order_metrics.average_of_lifetime_gross_revenue desc]
    limit: 500
    column_limit: 50
    query_timezone: America/New_York
    series_types: {}
    row: 2
    col: 8
    width: 8
    height: 4
  - title: Average Number of Orders
    name: Average Number of Orders
    model: rebecca_snowlooker
    explore: customers
    type: single_value
    fields: [customer_order_metrics.average_number_of_orders]
    limit: 500
    query_timezone: user_timezone
    listen: {}
    row: 2
    col: 16
    width: 8
    height: 4
  - name: Customer Orders
    type: text
    title_text: Customer Orders
    row: 0
    col: 0
    width: 24
    height: 2
  - name: Customer Order Distribution (2)
    type: text
    title_text: Customer Order Distribution
    row: 6
    col: 0
    width: 24
    height: 2
  - title: Customer Website Traffic by Age Group
    name: Customer Website Traffic by Age Group
    model: rebecca_snowlooker
    explore: customers
    type: looker_column
    fields: [events_summary.count_of_sessions, customers.age_tier, events_summary.session_start_year]
    pivots: [events_summary.session_start_year]
    fill_fields: [customers.age_tier, events_summary.session_start_year]
    sorts: [customers.age_tier, events_summary.session_start_year]
    limit: 500
    column_limit: 50
    query_timezone: user_timezone
    hidden_series: [2014 - events_summary.count_of_sessions]
    series_types: {}
    listen: {}
    row: 22
    col: 0
    width: 12
    height: 6
  - name: Customer Website Traffic
    type: text
    title_text: Customer Website Traffic
    row: 20
    col: 0
    width: 24
    height: 2
  - title: Average Session Duration by Regional Customers
    name: Average Session Duration by Regional Customers
    model: rebecca_snowlooker
    explore: customers
    type: looker_line
    fields: [events_summary.session_start_quarter, customers.usa_region, events_summary.average_session_duration_in_minutes]
    pivots: [customers.usa_region]
    fill_fields: [events_summary.session_start_quarter]
    sorts: [events_summary.session_start_quarter, customers.usa_region]
    limit: 500
    query_timezone: user_timezone
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
    series_types: {}
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    listen: {}
    row: 22
    col: 12
    width: 12
    height: 6
  - name: Revenue by Gender and Age
    title: Revenue by Gender and Age
    model: rebecca_snowlooker
    explore: order_items
    type: looker_column
    fields: [customers.age_tier, customers.gender, order_items.total_sale_price]
    pivots: [customers.gender]
    fill_fields: [customers.age_tier]
    filters:
      order_items.purchased_year: 1 years
    sorts: [customers.age_tier, customers.gender]
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
    stacking: normal
    limit_displayed_rows: false
    hide_legend: false
    legend_position: center
    font_size: '8'
    series_types: {}
    point_style: none
    series_colors:
      Female - order_items.total_revenue: pink
      Male - order_items.total_revenue: "#62bad4"
      Female - order_items.total_sale_price: pink
      Male - order_items.total_sale_price: "#62bad4"
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    label_rotation: -45
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    row: 14
    col: 12
    width: 12
    height: 6
  - title: Session and Conversion Rates by Gender
    name: Session and Conversion Rates by Gender
    model: rebecca_snowlooker
    explore: customers
    type: looker_line
    fields: [customers.gender, events_summary.session_start_quarter, events_summary.count_of_sessions,
      events_summary.conversion_rate]
    pivots: [customers.gender]
    fill_fields: [events_summary.session_start_quarter]
    sorts: [events_summary.session_start_quarter, customers.gender 0]
    limit: 500
    query_timezone: user_timezone
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: events_summary.count_of_sessions,
            id: Female - events_summary.count_of_sessions, name: Female - Events Summary
              Count of Sessions}, {axisId: events_summary.count_of_sessions, id: Male
              - events_summary.count_of_sessions, name: Male - Events Summary Count
              of Sessions}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, type: linear}, {label: !!null '', orientation: right,
        series: [{axisId: events_summary.conversion_rate, id: Female - events_summary.conversion_rate,
            name: Female - Events Summary Conversion Rate}, {axisId: events_summary.conversion_rate,
            id: Male - events_summary.conversion_rate, name: Male - Events Summary
              Conversion Rate}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, type: linear}]
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
    series_colors:
      Female - events_summary.count_of_sessions: pink
      Female - events_summary.conversion_rate: "#ffa7cc"
      Male - events_summary.count_of_sessions: "#94beff"
      Male - events_summary.conversion_rate: blue
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    listen: {}
    row: 28
    col: 0
    width: 12
    height: 6
  - name: Popular / Unpopular Brands
    type: text
    title_text: Popular / Unpopular Brands
    row: 34
    col: 0
    width: 24
    height: 2
  - title: Top 10 Brands Purchased
    name: Top 10 Brands Purchased
    model: rebecca_snowlooker
    explore: customers
    type: table
    fields: [products.brand, order_items.count_of_orders]
    sorts: [order_items.count_of_orders desc]
    limit: 10
    query_timezone: user_timezone
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: transparent
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen: {}
    row: 36
    col: 0
    width: 12
    height: 6
  - title: Top 10 Brands Returned
    name: Top 10 Brands Returned
    model: rebecca_snowlooker
    explore: customers
    type: table
    fields: [products.brand, order_items.count_of_orders, order_items.item_return_rate]
    sorts: [order_items.item_return_rate desc]
    limit: 5000
    dynamic_fields: [{table_calculation: item_purchase_rate, label: Item Purchase
          Rate, expression: "${order_items.count_of_orders}/${items_purchased}", value_format: !!null '',
        value_format_name: percent_2, _kind_hint: measure, _type_hint: number}, {
        table_calculation: items_purchased, label: Items Purchased, expression: 'sum(${order_items.count_of_orders})',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}]
    query_timezone: user_timezone
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: transparent
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_fields: [order_items.count_of_orders, items_purchased]
    listen: {}
    row: 36
    col: 12
    width: 12
    height: 6
  - title: Category Purchases
    name: Category Purchases
    model: rebecca_snowlooker
    explore: customers
    type: looker_column
    fields: [order_items.count_of_orders, products.category]
    sorts: [order_items.count_of_orders desc]
    limit: 5000
    query_timezone: user_timezone
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
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    legend_position: center
    series_types: {}
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
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: transparent
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields:
    listen: {}
    row: 42
    col: 0
    width: 24
    height: 6
  - name: Customer Trends
    type: text
    title_text: Customer Trends
    row: 48
    col: 0
    width: 24
    height: 2
  - title: Customer Cohorts - Gross Revenue
    name: Customer Cohorts - Gross Revenue
    model: rebecca_snowlooker
    explore: customers
    type: looker_line
    fields: [order_items.months_between_customer_creation_and_purchase_date, customers.customer_cohort,
      order_items.total_gross_revenue]
    pivots: [customers.customer_cohort]
    filters:
      customers.date_filter: 12 months
      order_items.months_between_customer_creation_and_purchase_date: "<=12"
    sorts: [order_items.total_gross_revenue desc 0, customers.customer_cohort]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: cumulative_gross_revenue, label: Cumulative
          Gross Revenue, expression: "if(\nis_null(${order_items.total_gross_revenue})\n\
          ,null\n,running_total(${order_items.total_gross_revenue}))\n\n", value_format: !!null '',
        value_format_name: usd, _kind_hint: measure, _type_hint: number}]
    query_timezone: user_timezone
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
    hidden_series: [Existing Customers - cumulative_gross_revenue]
    hide_legend: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    hidden_fields: [order_items.total_gross_revenue]
    listen: {}
    row: 50
    col: 0
    width: 24
    height: 6
  - title: New Customer Contribution to Revenue
    name: New Customer Contribution to Revenue
    model: rebecca_snowlooker
    explore: customers
    type: looker_bar
    fields: [customers.relative_customer_cohort, order_items.purchased_month, order_items.total_gross_revenue]
    pivots: [customers.relative_customer_cohort]
    fill_fields: [order_items.purchased_month]
    filters:
      order_items.purchased_month: 6 months
    sorts: [order_items.purchased_month desc, customers.relative_customer_cohort]
    limit: 500
    column_limit: 50
    query_timezone: user_timezone
    show_value_labels: false
    font_size: 12
    color_application:
      collection_id: 0a5cba20-3b6e-4739-b9e3-ba1d442d992d
      palette_id: 56b9d528-ab62-436e-a74d-7a44fc9d45c7
      options:
        steps: 5
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
    stacking: percent
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen: {}
    row: 64
    col: 0
    width: 12
    height: 8
  - title: Source of Customers
    name: Source of Customers
    model: rebecca_snowlooker
    explore: customers
    type: looker_area
    fields: [customers.created_month, customers.traffic_source, customers.count_of_customers]
    pivots: [customers.traffic_source]
    fill_fields: [customers.created_month]
    filters:
      customers.created_month: 12 months
    sorts: [customers.created_month desc, customers.traffic_source]
    limit: 500
    column_limit: 50
    query_timezone: user_timezone
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
    stacking: percent
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    listen: {}
    row: 72
    col: 12
    width: 12
    height: 6
  - title: Customer Cohorts - Buying Habits
    name: Customer Cohorts - Buying Habits
    model: rebecca_snowlooker
    explore: customers
    type: looker_line
    fields: [order_items.months_between_customer_creation_and_purchase_date, customers.customer_cohort,
      order_items.count_of_orders]
    pivots: [customers.customer_cohort]
    filters:
      customers.date_filter: 12 months
      order_items.months_between_customer_creation_and_purchase_date: "<=12"
    sorts: [customers.customer_cohort, order_items.count_of_orders desc 0]
    limit: 500
    column_limit: 50
    query_timezone: user_timezone
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
    hidden_series: [Existing Customers - cumulative_gross_revenue, Existing Customers
        - order_items.count_of_orders]
    hide_legend: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    hidden_fields: []
    listen: {}
    row: 64
    col: 12
    width: 12
    height: 8
  - title: Average Gross Revenue of Customer Cohorts
    name: Average Gross Revenue of Customer Cohorts
    model: rebecca_snowlooker
    explore: customers
    type: looker_column
    fields: [customers.customer_cohort, order_items.average_gross_revenue]
    filters:
      customers.date_filter: 12 months
    sorts: [customers.customer_cohort]
    limit: 500
    column_limit: 50
    query_timezone: user_timezone
    series_types: {}
    listen: {}
    row: 72
    col: 0
    width: 12
    height: 6
  - title: Customer Cohorts - Gross Revenue (Table)
    name: Customer Cohorts - Gross Revenue (Table)
    model: rebecca_snowlooker
    explore: customers
    type: table
    fields: [order_items.months_between_customer_creation_and_purchase_date, customers.customer_cohort,
      order_items.total_gross_revenue]
    pivots: [customers.customer_cohort]
    filters:
      customers.date_filter: 12 months
      order_items.months_between_customer_creation_and_purchase_date: "<=12"
      customers.customer_cohort: "-Existing Customers"
    sorts: [order_items.total_gross_revenue desc 0, customers.customer_cohort]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: cumulative_gross_revenue, label: Cumulative
          Gross Revenue, expression: "if(\nis_null(${order_items.total_gross_revenue})\n\
          ,null\n,running_total(${order_items.total_gross_revenue}))\n\n", value_format: !!null '',
        value_format_name: usd, _kind_hint: measure, _type_hint: number}]
    query_timezone: user_timezone
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#2196F3",
        font_color: !!null '', color_application: {collection_id: 0a5cba20-3b6e-4739-b9e3-ba1d442d992d,
          palette_id: 56b9d528-ab62-436e-a74d-7a44fc9d45c7, options: {steps: 5, constraints: {
              min: {type: minimum}, mid: {type: median}, max: {type: maximum}}, mirror: true,
            reverse: false, stepped: true}}, bold: false, italic: false, strikethrough: false,
        fields: [cumulative_gross_revenue]}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    hidden_series: [Existing Customers - cumulative_gross_revenue]
    hide_legend: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    hidden_fields: [order_items.total_gross_revenue]
    series_types: {}
    listen: {}
    row: 56
    col: 0
    width: 24
    height: 8
