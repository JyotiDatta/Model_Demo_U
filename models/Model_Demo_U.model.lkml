connection: "looker_partner_demo"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
include: "U_Dashboard.dashboard"

label: "Jyoti's first Model During Udemy Practice"

datagroup:  Model_Demo_datagroup{
  sql_trigger:  select 1 ;;
  max_cache_age: "2 hours"
}

datagroup: Inventory_datagroup{
  sql_trigger:  select 1 ;;
  max_cache_age: "2 hours"
}



explore: order_items {
  persist_with: Model_Demo_datagroup
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: products {
    type:  left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
    fields: [products.brand, products.category, products.department, products.count]
  }

 join: users {
   type:left_outer
   sql_on: ${order_items.user_id} = ${users.id} ;;
  relationship: many_to_one
 }
}

explore: inventory_items {
  persist_with: Inventory_datagroup
}
