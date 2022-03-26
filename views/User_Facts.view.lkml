view: user_Facts {
  derived_table: {
    sql: SELECT
      order_items.user_id as user_id
      , COUNT(distinct order_items.order_id) as lifetime_order_count
      , SUM (order_items.sale_price) as lifetime_revenue
      FROM
        order_items
      GROUP BY
        user_id
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
    hidden: yes
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}."user_id" ;;
    primary_key:  yes
  }

  dimension: lifetime_order_count {
    type: number
    sql: ${TABLE}."lifetime_order_count";;

  }

  dimension: lifetime_revenue {
    type: number
    sql: ${TABLE}."lifetime_revenue" ;;
    value_format_name: decimal_2
  }

  measure: average_lifetime_order_count {
    type: average
    sql: ${lifetime_order_count} ;;
    value_format_name: decimal_2
  }

  measure: average_lifetime_revenue {
    type: average
    sql:  ${lifetime_revenue} ;;
    value_format_name: decimal_2
  }


  set: detail {
    fields: [user_id, lifetime_order_count, lifetime_revenue]
  }
}
