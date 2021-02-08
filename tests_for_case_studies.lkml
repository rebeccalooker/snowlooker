test: most_users_with_returns {
  explore_source: order_items {
    column: percent_of_users_with_returns {}
    column: purchased_month {}
    filters: {
      field: order_items.purchased_year
      value: "2019"
    }
    sorts: [order_items.percent_of_users_with_returns: desc]
    limit: 1
  }
  assert: answer_is_october {
      expression: ${order_items.purchased_month} = date(2019,10,1) ;;
  }
}

test: lifetime_revenue_cohort_quantity {
  explore_source: order_items {
    column: lifetime_revenue_tier { field: customer_order_metrics.lifetime_revenue_tier }
    column: count_of_customers { field: customers.count_of_customers }
    sorts: [customers.count_of_customers: desc]
    limit: 1
  }
  assert: answer_is_100_to_500 {
    expression: ${customer_order_metrics.lifetime_revenue_tier} = ">= 100.0 and < 500.0" ;;
  }
}

test: brand_ranking {
  explore_source: order_items {
    column: brand { field: products.brand }
    column: total_sale_price {}
    filters: {
      field: products.category
      value: "Jeans"
    }
    filters: {
      field: order_items.purchased_date
      value: "2018"
    }
    sorts: [order_items.total_sale_price: desc]
    limit: 10
  }
  assert: 7_for_all_mankind_is_4th {
    expression: if(row() != 4,"Yes",
                  if(${products.brand} = "7 For All Mankind","Yes","No"
                    )
                  ) ;;
  }
}
