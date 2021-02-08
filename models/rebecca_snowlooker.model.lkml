connection: "snowlooker"

# include all the views
include: "/views/**/*.view"
include: "/dashboards/*.dashboard"
include: "/tests_for_case_studies.lkml"

datagroup: adam_minton_case_study_default_datagroup {
  sql_trigger: SELECT CURRENT_DATE ;;
  max_cache_age: "24 hours"
}
# aggregate_awareness: yes
persist_with: adam_minton_case_study_default_datagroup

access_grant: inventory {
  user_attribute: am_security_demo_department
  allowed_values: ["inventory","admin"]
}

access_grant: marketing {
  user_attribute: am_security_demo_department
  allowed_values: ["marketing","admin"]
}

access_grant: finance {
  user_attribute: am_security_demo_department
  allowed_values: ["finance","admin"]
}

explore: inventory_items {
  required_access_grants: [inventory]
  label: "Inventory Analysis"
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.product_id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.distribution_center_id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  persist_for: "0 seconds"
  required_access_grants: [marketing]

  always_join: [customers]

#   access_filter: {
#     field: products.brand
#     user_attribute: brand
#   }
#  sql_always_where: ${purchased_date} > to_date('20170101','YYYYMMDD') ;;
  label: "Order Analysis"
  join: inventory_items {
    #required_access_grants: [inventory]
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.inventory_item_id} ;;
    relationship: one_to_one
  }

  join: customers {
    type: left_outer
    sql_on: ${order_items.customer_id} = ${customers.customer_id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.product_id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.distribution_center_id} ;;
    relationship: many_to_one
  }

  join: customer_order_sequence {
    type: left_outer
    sql_on: ${customer_order_sequence.order_id} = ${order_items.order_id} ;;
    relationship: one_to_one
  }

  join: customer_order_metrics {
    type: left_outer
    sql_on: ${order_items.customer_id} = ${customer_order_metrics.customer_id} ;;
    relationship: one_to_one
  }
}

explore: customers {
  required_access_grants: [marketing]
  label: "Customer Analysis"
  join: customer_order_metrics {
    type: left_outer
    sql_on: ${customers.customer_id} = ${customer_order_metrics.customer_id} ;;
    relationship: one_to_one
  }
  join: order_items {
    type: left_outer
    sql_on: ${customers.customer_id} = ${order_items.customer_id} ;;
    relationship: one_to_many
  }
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.inventory_item_id} ;;
    relationship: one_to_one
  }
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.product_id} ;;
    relationship: many_to_one
  }
#  join: events_summary {
#    view_label: "Event Summary Related to Orders"
#    type: left_outer
#    sql_on: ${order_items.customer_id} = ${events_summary.customer_id} and ${order_items.purchased_date} = ${events_summary.purchase_date} ;;
#    relationship: one_to_one
#  }
  join: events_summary {
    type: left_outer
    sql_on: ${customers.customer_id} = ${events_summary.customer_id} ;;
    relationship: one_to_many
  }
}

explore: events_summary {
  persist_for: "0 seconds"
  required_access_grants: [marketing]
  label: "Website Metrics"
  join: events {
    type: left_outer
    sql_on: ${events_summary.session_id} = ${events.session_id} ;;
    relationship: one_to_many
  }
}

# datagroup: rebecca_snowlooker_default_datagroup {
#   # sql_trigger: SELECT MAX(id) FROM etl_log;;
#   max_cache_age: "1 hour"
# }
#
# persist_with: rebecca_snowlooker_default_datagroup
#
# explore: distribution_centers {}
#
# explore: etl_jobs {}
#
# explore: events {
#   join: users {
#     type: left_outer
#     sql_on: ${events.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: inventory_items {
#   join: products {
#     type: left_outer
#     sql_on: ${inventory_items.product_id} = ${products.id} ;;
#     relationship: many_to_one
#   }
#
#   join: distribution_centers {
#     type: left_outer
#     sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: order_items {
#   join: users {
#     type: left_outer
#     sql_on: ${order_items.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
#
#   join: inventory_items {
#     type: left_outer
#     sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
#     relationship: many_to_one
#   }
#
#   join: products {
#     type: left_outer
#     sql_on: ${inventory_items.product_id} = ${products.id} ;;
#     relationship: many_to_one
#   }
#
#   join: distribution_centers {
#     type: left_outer
#     sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: products {
#   join: distribution_centers {
#     type: left_outer
#     sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: users {}
