- dashboard: fashion_ly_health_dashboard
  title: Fashion.ly Health Dashboard
  layout: newspaper
  elements:
  - name: Avg Customer Spend Past 30 Days
    title: Avg Customer Spend Past 30 Days
    model: rebecca_snowlooker
    explore: order_items
    type: single_value
    fields: [order_items.average_spend_per_customer]
    filters: {}
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
    listen:
      Region: customers.usa_region
      Order Date: order_items.purchased_date
    row: 0
    col: 12
    width: 6
    height: 4
  - name: Sales Yesterday
    title: Sales Yesterday
    model: rebecca_snowlooker
    explore: order_items
    type: single_value
    fields: [order_items.total_sale_price, order_items.purchased_date]
    filters: {}
    sorts: [order_items.purchased_date desc]
    limit: 500
    dynamic_fields: [{table_calculation: day_prior, label: Day Prior, expression: 'offset(${order_items.total_sale_price},1)',
        value_format: !!null '', value_format_name: usd, _kind_hint: measure, _type_hint: number}]
    query_timezone: America/New_York
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    single_value_title: Sales Yesterday
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    listen:
      Region: customers.usa_region
      Order Date: order_items.purchased_date
    row: 0
    col: 0
    width: 6
    height: 4
  - name: New Customers
    title: New Customers
    model: rebecca_snowlooker
    explore: order_items
    type: single_value
    fields: [customers.count_of_customers, customers.count_of_new_customers]
    filters:
      customers.date_filter: yesterday
    limit: 5000
    dynamic_fields: [{table_calculation: new_customers, label: New Customers, expression: "${customers.count_of_new_customers}/sum(${customers.count_of_customers})",
        value_format: !!null '', value_format_name: percent_2, _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/New_York
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    single_value_title: New Customers Yesterday
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: ''
    series_types: {}
    hidden_fields: [customers.count_of_customers]
    listen:
      Region: customers.usa_region
      Order Date: order_items.purchased_date
    row: 0
    col: 18
    width: 6
    height: 4
  - name: Gross Margin Last 30 Days
    title: Gross Margin Last 30 Days
    model: rebecca_snowlooker
    explore: order_items
    type: single_value
    fields: [order_items.gross_margin_percentage]
    filters: {}
    limit: 500
    query_timezone: America/New_York
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    single_value_title: Gross Margin % (30 Days)
    value_format: ''
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    listen:
      Region: customers.usa_region
      Order Date: order_items.purchased_date
    row: 0
    col: 6
    width: 6
    height: 4
  - name: Gross Revenue and Margin % Past 12 Months
    title: Gross Revenue and Margin % Past 12 Months
    model: rebecca_snowlooker
    explore: order_items
    type: looker_column
    fields: [order_items.purchased_month, order_items.total_gross_revenue, order_items.gross_margin_percentage]
    fill_fields: [order_items.purchased_month]
    filters:
      order_items.purchased_month: 12 months
    sorts: [order_items.purchased_month]
    limit: 500
    query_timezone: America/New_York
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: order_items.total_gross_revenue,
            id: order_items.total_gross_revenue, name: Total Gross Revenue}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: '', orientation: right, series: [{axisId: order_items.gross_margin_percentage,
            id: order_items.gross_margin_percentage, name: Gross Margin Percentage}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
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
    series_types:
      order_items.total_gross_margin_amount: line
      order_items.gross_margin_percentage: line
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    x_axis_label_rotation: -45
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen:
      Region: customers.usa_region
      Order Date: order_items.purchased_date
    row: 6
    col: 12
    width: 12
    height: 6
  - name: Daily Customer Growth
    title: Daily Customer Growth
    model: rebecca_snowlooker
    explore: order_items
    type: looker_column
    fields: [customers.created_day_of_month, customers.created_month, customers.count_of_customers]
    pivots: [customers.created_month]
    fill_fields: [customers.created_day_of_month, customers.created_month]
    filters:
      customers.created_month: 2 months
    sorts: [customers.created_day_of_month, customers.created_month]
    limit: 500
    dynamic_fields: [{table_calculation: average_customers_added_this_month, label: Average
          Customers Added This Month, expression: 'mean(pivot_index(${customers.count_of_customers},2))',
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: supermeasure,
        _type_hint: number}]
    query_timezone: America/New_York
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: customers.count_of_customers,
            id: 2019-07 - customers.count_of_customers, name: 2019-07 - Customers
              Count of Customers}, {axisId: customers.count_of_customers, id: 2019-08
              - customers.count_of_customers, name: 2019-08 - Customers Count of Customers},
          {axisId: average_customers_added_this_month, id: average_customers_added_this_month,
            name: Average Customers Added This Month}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
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
    series_types:
      growth_percentage: line
      average_customers_added_this_month: line
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    reference_lines: [{reference_type: margins, range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, label_position: right, color: "#000000",
        line_value: "[deviation, mean, deviation]", margin_bottom: deviation}]
    trend_lines: []
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen:
      Region: customers.usa_region
      Order Date: order_items.purchased_date
    row: 32
    col: 0
    width: 24
    height: 6
  - name: New vs Old Customers Sales Makeup
    title: New vs Old Customers Sales Makeup
    model: rebecca_snowlooker
    explore: order_items
    type: looker_area
    fields: [customers.new_customer_indicator, order_items.purchased_date, order_items.total_sale_price]
    pivots: [customers.new_customer_indicator]
    fill_fields: [order_items.purchased_date, customers.new_customer_indicator]
    filters: {}
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
    listen:
      Region: customers.usa_region
      Order Date: order_items.purchased_date
    row: 14
    col: 12
    width: 12
    height: 6
  - name: Profitability by Location
    title: Profitability by Location
    model: rebecca_snowlooker
    explore: order_items
    type: looker_map
    fields: [order_items.average_gross_margin_amount, customers.zipcode]
    filters:
      order_items.average_gross_margin_amount: NOT NULL
      customers.country: USA
    sorts: [order_items.average_gross_margin_amount desc]
    limit: 5000
    column_limit: 50
    query_timezone: America/New_York
    map_position: custom
    map_latitude: 31.76582930528941
    map_longitude: -86.47819519042969
    map_zoom: 5
    listen:
      Region: customers.usa_region
      Order Date: order_items.purchased_date
    row: 26
    col: 0
    width: 24
    height: 6
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
    listen:
      Region: customers.usa_region
      Order Date: order_items.purchased_date
    row: 14
    col: 0
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
    listen:
      Region: customers.usa_region
      Order Date: order_items.purchased_date
    row: 20
    col: 12
    width: 12
    height: 6
  - name: Top Products
    title: Top Products
    model: rebecca_snowlooker
    explore: order_items
    type: looker_column
    fields: [products.brand, order_items.gross_margin_percentage, order_items.total_sale_price]
    filters:
      order_items.status: Processing,Complete,Shipped
    sorts: [percentage_of_total_revenue desc]
    limit: 5000
    column_limit: 50
    dynamic_fields: [{table_calculation: percentage_of_total_revenue, label: Percentage
          of Total Revenue, expression: "${order_items.total_sale_price} / sum(${order_items.total_sale_price})",
        value_format: !!null '', value_format_name: percent_2, _kind_hint: measure,
        _type_hint: number}, {table_calculation: running_sum_of_of_total_revenue,
        label: Running Sum of % of Total Revenue, expression: 'running_total(${percentage_of_total_revenue})',
        value_format: !!null '', value_format_name: percent_2, _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/New_York
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: order_items.total_sale_price,
            id: order_items.total_sale_price, name: Total Sale Price}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: !!null '', orientation: left, series: [{axisId: order_items.gross_margin_percentage,
            id: order_items.gross_margin_percentage, name: Gross Margin Percentage}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}, {label: !!null '', orientation: right,
        series: [{axisId: percentage_of_total_revenue, id: percentage_of_total_revenue,
            name: Percentage of Total Revenue}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
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
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    legend_position: center
    series_types:
      percentage_of_total_revenue: line
      running_sum_of_of_total_revenue: line
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    reference_lines: []
    trend_lines: []
    ordering: none
    show_null_labels: false
    show_dropoff: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [order_items.total_revenue, order_items.total_sale_price, percentage_of_total_revenue]
    listen:
      Region: customers.usa_region
      Order Date: order_items.purchased_date
    row: 20
    col: 0
    width: 12
    height: 6
  - name: Yearly Revenue Trend
    title: Yearly Revenue Trend
    model: rebecca_snowlooker
    explore: order_items
    type: looker_column
    fields: [order_items.purchased_year, order_items.total_gross_revenue]
    sorts: [order_items.purchased_year]
    limit: 500
    dynamic_fields: [{table_calculation: previous_row, label: Previous Row, expression: 'offset(${order_items.total_gross_revenue},-1)',
        value_format: !!null '', value_format_name: usd, _kind_hint: measure, _type_hint: number},
      {table_calculation: growth_percentage, label: Growth Percentage, expression: "if(trunc_years(now())\
          \ = ${order_items.purchased_year},null,\n  \n  (${order_items.total_gross_revenue}-${previous_row})/${previous_row}\n\
          \  )", value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/New_York
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: order_items.total_revenue,
            id: order_items.total_revenue, name: Total Revenue}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: !!null '', orientation: right, series: [{axisId: growth_percentage,
            id: growth_percentage, name: Growth Percentage}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
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
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: last
      num_rows: '4'
    hidden_series: []
    legend_position: center
    series_types:
      growth_percentage: line
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
    up_color: "#62bad4"
    down_color: "#a9c574"
    total_color: "#929292"
    hidden_fields: [previous_quarter, previous_row]
    listen:
      Region: customers.usa_region
      Order Date: order_items.purchased_date
    row: 6
    col: 0
    width: 12
    height: 6
  - name: Revenue Trends
    type: text
    title_text: Revenue Trends
    body_text: ''
    row: 4
    col: 0
    width: 24
    height: 2
  - name: Revenue Drivers
    type: text
    title_text: Revenue Drivers
    row: 12
    col: 0
    width: 24
    height: 2
  filters:
  - name: Order Date
    title: Order Date
    type: field_filter
    default_value: 90 days
    allow_multiple_values: true
    required: false
    model: rebecca_snowlooker
    explore: order_items
    listens_to_filters: []
    field: order_items.purchased_date
  - name: Region
    title: Region
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: rebecca_snowlooker
    explore: order_items
    listens_to_filters: []
    field: customers.usa_region
