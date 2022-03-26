# # This is a SQL derived table
# view: order_facts {
#   # # You can specify the table name if it's different from the view name:

#   derived_table: {
#     explore_source: order_items {
#       column: created_month {}
#       # column: total_profit {}
#       column: order_items_count {}
#       # derived_column: total_profit_per_item {
#       #   sql: total_profit/ nullif(order_items_count,0) ;;
#       # }
#       # derived_column: total_profit_per_item_last_year {
#       #   sql: lag(total_profit/order_items_count, 12) Over(order by created_month asc) ;;
#       # }
#     }
#     sql: SELECT
#         order_items.order_id as Order_Id
#         ,COUNT(*) as Items_Count
#         ,SUM (order_items.sale_price) as Lifetime_Revenue
#         FROM order_items
#         GROUP BY order_id
#       --LIMIT 10
#       ;;
#   }

#   measure: count {
#     type: count
#     drill_fields: [detail*]
#     hidden: yes
#   }


#   dimension: order_id {
#     type: number
#     sql: ${TABLE}."order_id" ;;
#     primary_key: yes
#   }

#   dimension: created_month{
#     type: date_month

#   }
#   dimension: order_items_count {
#     type: number
#     sql: ${TABLE}."items_count" ;;
#   }


#   dimension: items_count {
#     type: number
#     sql: ${TABLE}."items_count" ;;
#   }

#   dimension: lifetime_revenue {
#     type: number
#     sql: ${TABLE}."lifetime_revenue" ;;
#   }

#   measure: average_items_per_order {
#     type: average
#   sql: ${items_count} ;;
#   }

#   set: detail {
#     fields: [order_id, items_count, lifetime_revenue]
#   }
# }
