connection: "looker_partner_demo"

# include all the views
include: "/views/**/*.view"

datagroup: jyoti_googlebigquery_looker_demo_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: jyoti_googlebigquery_looker_demo_default_datagroup

datagroup: date_dg {
  sql_trigger: select current date ;;
  max_cache_age: "24 hours"
}

datagroup: order_items_dg {
  sql_trigger: select max(created_at) from order_items ;;
  max_cache_age: "4 hours"
}


explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: products {
  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: distribution_centers {}

#explore: etl_jobs {}

explore: order_items {
  persist_with: order_items_dg
  conditionally_filter: {
    filters: [order_items.created_year: "2021"]
    unless: [users.country]
  }

#Below filter created for Udemy practice
# SQL FILTER DOES NOT SHOW UNDER FILTERS
#sql_always_where: ${created_date} >= '2020-10-11' ;;
 # sql_always_having: ${count} >= 1 ;;
  # Always filter shows under filters, but can't be removed by users
 #always_filter: {
 #   filters: [order_items.status: "Complete", order_items.created_year: "2020"]
 # }

#---------------
  # always_filter: {
  #   filters: {
  #     field: order_items.created_date
  #     value: "Last 30 days"
  # }
 # }

  # join: order_facts {
  #   type:  left_outer
  #   sql_on: ${order_facts.order_id} = ${order_items.order_id} ;;
  #   relationship: one_to_one
  # }

  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }

  join: core_products_u{
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: users {
  persist_with: date_dg
  join: order_items {
    type:  left_outer
    sql_on: ${users.id} = ${order_items.user_id} ;;
    relationship: one_to_many
  }

  join: user_Facts {
    type:  left_outer
    sql_on: ${users.id} = ${user_Facts.user_id} ;;
    relationship: one_to_one

  }
}
