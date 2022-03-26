view: users {
  sql_table_name: looker-private-demo.ecomm.users ;;

  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
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

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: from_Cowra_or_NewCity{
    type:  yesno
    sql: ${city} = "New City" or ${city} = "Cowra" ;;
  }
  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
    map_layer_name: us_states
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  dimension: age_tier {
    type: tier
    tiers: [18, 25, 35,45,65, 75,90]
    sql:  ${age} ;;
  }

dimension: city_state {
  type: string
  sql: concat(${city},' ', ${state}) ;;
}

dimension: is_email_source {
  type:  yesno
  sql: ${traffic_source} = "Email";;
}

  measure: count {
    type: count
    drill_fields: [id, last_name, first_name, order_items.count, events.count]
  }

measure: average_age {
  type: average
  sql: ${age} ;;
}

}
