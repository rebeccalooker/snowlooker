view: customers {
  sql_table_name: public.users ;;

##############BASE TABLE DIMENSIONS##############
#Dimensions available directly on the underlying table, no transformations

  dimension: customer_id {
    primary_key: yes
    type: number
    description: "Unique identifier of a customer"
    sql: ${TABLE}.ID ;;
  }

  dimension: age {
    type: number
    description: "Age of a customer"
    sql: ${TABLE}.AGE ;;
  }

  dimension: age_tier {
    type: tier
    description: "7 common age tiers"
    tiers: [26, 36, 51, 66]
    style: integer
    sql: ${age} ;;
  }

  dimension: city {
    type: string
    description: "City where customer is located"
    sql: ${TABLE}.CITY ;;
  }

  dimension: country {
    type: string
    description: "Country where customer is located"
    map_layer_name: countries
    sql: ${TABLE}.COUNTRY ;;
  }

  dimension_group: created {
    type: time
    description: "Date customer was created"
    timeframes: [
      raw,
      time,
      date,
      day_of_month,
      week,
      month,
      month_name,
      quarter,
      quarter_of_year,
      year
    ]
    sql: ${TABLE}.CREATED_AT ;;
  }

  dimension: email {
    type: string
    description: "Email of customer"
    sql: ${TABLE}.EMAIL ;;
  }

  dimension: first_name {
    type: string
    hidden: yes
    description: "First name of customer"
    sql: ${TABLE}.FIRST_NAME ;;
  }

  dimension: last_name {
    type: string
    hidden:  yes
    description: "Last name of customer"
    sql: ${TABLE}.LAST_NAME ;;
  }

  dimension: gender {
    type: string
    description: "Indicates whether the customer is male or female"
    sql: ${TABLE}.GENDER ;;
  }

  dimension: latitude {
    type: number
    description: "Latitude position of customer"
    hidden: yes
    sql: ${TABLE}.LATITUDE ;;
  }

  dimension: longitude {
    type: number
    description: "Londitude position of customer"
    hidden: yes
    sql: ${TABLE}.LONGITUDE ;;
  }

  dimension: state {
    type: string
    description: "State where customer is located"
    sql: ${TABLE}.STATE ;;
    map_layer_name: us_states
  }

  dimension: traffic_source {
    type: string
    description: "How customer was acquired (Search, Email, Facebook, Display, or Organic)"
    sql: ${TABLE}.TRAFFIC_SOURCE ;;
  }

  dimension: zipcode {
    type: zipcode
    description: "Zipcode of customer"
    sql: ${TABLE}.ZIP ;;
  }

##############DERIVED DIMENSIONS/FILTERS##############
#Dimensions that utilize other data transformations or contain business logic

  dimension: location {
    type:  location
    description: "GPS location of customer"
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }

  dimension: name {
    type: string
    description: "Name of customer"
    sql: ${first_name} || ' ' || ${last_name} ;;
    required_fields: [customer_id]
  }

  dimension: usa_region {
    type: string
    description: "Classifies a state into either Northeast, Midwest, South, or West"
    label: "USA Region"
    sql: CASE
            WHEN ${state} in ('Maine','New Hampshire','Vermont','Massachusetts','Rhode Island','Connecticut','New York','Pennsylvania','New Jersey') THEN 'Northeast'
            WHEN ${state} in ('Wisconsin','Michigan','Illinois','Indiana','Ohio','North Dakota','South Dakota','Nebraska','Kansas','Minnesota','Iowa','Missouri') THEN 'Midwest'
            WHEN ${state} in ('Delaware','Maryland','District of Columbia','Virginia','West Virginia','North Carolina','South Carolina','Georgia','Florida','Kentucky','Tennessee','Mississippi','Alabama','Oklahoma','Texas','Arkansas','Louisiana') THEN 'South'
            WHEN ${state} in ('Idaho','Montana','Wyoming','Nevada','Utah','Colorado','Arizona','New Mexico','Alaska','Washington','Oregon','California','Hawaii') THEN 'West'
            ELSE 'Unclassified'
          END ;;
  }

  dimension: new_customer_indicator {
    type: yesno
    description: "New customers have created their account in the last 90 days"
    sql: ${created_date} >= (current_date - 90);;
  }

  filter: date_filter {
    type: date_time
    description: "Utilize with Number of New Customers to determine period of analysis"
    default_value: "yesterday"
  }

  dimension: check_created_date_with_date_filter {
    type: yesno
    hidden: yes
    sql:
    {% condition date_filter %} ${created_raw} {% endcondition %};;
  }

  dimension_group: since_signup {
    type: duration
    sql_start: ${created_date} ;;  # often this is a single database column
    sql_end: current_date ;;  # often this is a single database column
    intervals: [year, month, week, day] # valid intervals described below
  }

  dimension: customer_cohort {
    type: string
    description: "Groups customers based on parameter and remaining customers are grouped by creation_month"
    sql: CASE WHEN ${check_created_date_with_date_filter} = 'yes'
              THEN ${created_month}
              ELSE 'Existing Customers'
         END;;
  }

  dimension: relative_customer_cohort {
    type: string
    description: "Relative customer cohorts to the order purchase date, creates 13 buckets"
    sql: CASE WHEN TO_CHAR(${order_items.purchased_date},'YYYYMM') = TO_CHAR(${created_date},'YYYYMM') THEN 'Current Month'
              WHEN TO_CHAR(dateadd(month,-1,${order_items.purchased_date}),'YYYYMM') =  TO_CHAR(${created_date},'YYYYMM') THEN 'Month -01'
              WHEN TO_CHAR(dateadd(month,-2,${order_items.purchased_date}),'YYYYMM') =  TO_CHAR(${created_date},'YYYYMM') THEN 'Month -02'
              WHEN TO_CHAR(dateadd(month,-3,${order_items.purchased_date}),'YYYYMM') =  TO_CHAR(${created_date},'YYYYMM') THEN 'Month -03'
              WHEN TO_CHAR(dateadd(month,-4,${order_items.purchased_date}),'YYYYMM') =  TO_CHAR(${created_date},'YYYYMM') THEN 'Month -04'
              WHEN TO_CHAR(dateadd(month,-5,${order_items.purchased_date}),'YYYYMM') =  TO_CHAR(${created_date},'YYYYMM') THEN 'Month -05'
              WHEN TO_CHAR(dateadd(month,-6,${order_items.purchased_date}),'YYYYMM') =  TO_CHAR(${created_date},'YYYYMM') THEN 'Month -06'
              WHEN TO_CHAR(dateadd(month,-7,${order_items.purchased_date}),'YYYYMM') =  TO_CHAR(${created_date},'YYYYMM') THEN 'Month -07'
              WHEN TO_CHAR(dateadd(month,-8,${order_items.purchased_date}),'YYYYMM') =  TO_CHAR(${created_date},'YYYYMM') THEN 'Month -08'
              WHEN TO_CHAR(dateadd(month,-9,${order_items.purchased_date}),'YYYYMM') =  TO_CHAR(${created_date},'YYYYMM') THEN 'Month -09'
              WHEN TO_CHAR(dateadd(month,-10,${order_items.purchased_date}),'YYYYMM') =  TO_CHAR(${created_date},'YYYYMM') THEN 'Month -10'
              WHEN TO_CHAR(dateadd(month,-11,${order_items.purchased_date}),'YYYYMM') =  TO_CHAR(${created_date},'YYYYMM') THEN 'Month -11'
              WHEN TO_CHAR(dateadd(month,-12,${order_items.purchased_date}),'YYYYMM') =  TO_CHAR(${created_date},'YYYYMM') THEN 'Month -12'
              ELSE 'Previous'
         END ;;
  }

##############MEASURES##############
#Measures that utilize aggregates for creating KPIs, charts, etc.

  measure: count_of_customers {
    type: count
    description: "Count of customers"
    drill_fields: [customer_drill*]
  }

  measure: running_total_of_customers {
    type: running_total
    description: "Running total of customers"
    sql: ${count_of_customers} ;;
  }

  measure: count_of_new_customers {
    type: count
    description: "Utilize with Date Filter to determine period of analysis"
    filters: {
      field: check_created_date_with_date_filter
      value: "yes"
    }
    drill_fields: [customer_drill*]
  }

  parameter: since_signup_aggregation {
    type: string
    allowed_value: {
      label: "Days"
      value: "day"
    }
    allowed_value: {
      label: "month"
      value: "month"
    }
    allowed_value: {
      label: "Years"
      value: "year"
    }

    default_value: "_user_attributes['test_string']"
  }

  measure: average_since_signup {
    type: average
    description: "Use with Since Signup Aggregation filter to select days, months, or years. Will default to days."
    sql: {% if since_signup_aggregation._parameter_value == 'day' %}
      ${days_since_signup}
    {% elsif since_signup_aggregation._parameter_value == 'month' %}
      ${months_since_signup}
    {% elsif since_signup_aggregation._parameter_value == 'year' %}
      ${years_since_signup}
    {% else  %}
       ${days_since_signup}
    {% endif %} ;;
    value_format_name: decimal_1
#    suggest_dimension: customers.since_singup_aggregation
  }

##############DRILL SET##############
#Default drill set for measures

  set: customer_drill {
    fields: [customer_id, name, gender, age, email, city, state, zipcode, country, location, ]
  }
}
