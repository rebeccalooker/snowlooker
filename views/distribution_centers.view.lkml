view: distribution_centers {
  sql_table_name: public.distribution_centers ;;

##############BASE TABLE DIMENSIONS##############
#Dimensions available directly on the underlying table, no transformations

  dimension: distribution_center_id {
    primary_key: yes
    description: "Unique identifier of each distribution center"
    hidden: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: latitude {
    type: number
    description: "Latitude position of distribution center"
    hidden: yes
    sql: ${TABLE}.LATITUDE ;;
  }

  dimension: longitude {
    type: number
    description: "Longitude position of distribution center"
    hidden:  yes
    sql: ${TABLE}.LONGITUDE ;;
  }

  dimension: name {
    type: string
    description: "Name of the distribution center"
    label: "DC Name"
    sql: ${TABLE}.NAME ;;
  }

##############DERIVED DIMENSIONS/FILTERS##############
#Dimensions that utilize other data transformations or contain business logic

  dimension: dc_location {
    type:  location
    description: "GPS location of distribution center"
    label: "DC Location"
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }

##############MEASURES##############
#Measures that utilize aggregates for creating KPIs, charts, etc.

  measure: count_of_dc {
    type: count
    description: "Count of distribution centers"
    label: "Count of DC"
  }

##############DRILL SET##############
#Default drill set for measures



}
