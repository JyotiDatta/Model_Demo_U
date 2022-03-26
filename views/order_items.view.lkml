view: order_items {
  sql_table_name: looker-private-demo.ecomm.order_items ;;

  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: delivered {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: delivery_days {
    type: number
    sql:  DATE_DIFF(${delivered_date}, ${created_date}, DAY) ;;
    #sql_start: ${delivered_date} ;;
    #sql_end: ${created_date} ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: shipping_days {
    type:  duration
    sql_start: ${created_date} ;;
    sql_end: ${delivered_date} ;;
    intervals: [day]
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension_group: shipped {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.last_name,
      users.id,
      users.first_name,
      inventory_items.id,
      inventory_items.product_name
    ]
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
    value_format_name: usd
  }

  measure: total_sales{
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd_0
  }

  measure: total_revenue_from_completed_orders{
    type:  sum
    sql: ${sale_price} ;;
    filters: [status: "Complete"]
    value_format_name: usd_0
  }

measure: total_revenue_from_cancelled_orders{
  type:  sum
  sql: ${sale_price} ;;
  filters: [status: "Cancelled"]
  value_format_name: usd_0
}

  measure: sales_price_percent {
    type:  percent_of_total
    sql: ${total_sales} ;;
    # sql:  100 * sum(${sale_price})/ NULLIF(${total_sales},0) ;;
  }

  measure: avg_sales {
    type: average
    sql: ${TABLE}.sale_price ;;
  }

  measure: count_of_orders {
    description: "A count of distinct orders"
    type: count_distinct
    sql: ${order_id} ;;
  }

  measure: Average_spend_per_user {
    type: number
    sql: 1.0 * ${total_sales}/nullif(${count},0);;
  }

  measure: total_sales_email_users {
    type: sum
    sql: ${TABLE}.sale_price ;;
    filters: [users.is_email_source: "yes"]
  }
}
