view: core_products_u {

  sql_table_name: looker-private-demo.ecomm.order_items ;;

  dimension: id_primary_key {
    primary_key: yes
    type:  number
    sql: ${TABLE}.id ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: cost {
    type:  number
    sql: ${TABLE}.cost ;;
  }

  dimension: retail_price {
    type: number
    sql:  ${TABLE}.retail_price ;;
  }

  measure: count {
    type: count
    drill_fields: [id_primary_key, brand]
  }

}
