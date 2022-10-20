view: test_dialogflow_agent {
  sql_table_name: `siddhesh_bhere_qai_assignment3.test_dialogflow_agent`
    ;;

  dimension: insert_id {
    type: string
    sql: ${TABLE}.insertId ;;
  }

  dimension: labels__protocol {
    type: string
    sql: ${TABLE}.labels.protocol ;;
    group_label: "Labels"
    group_item_label: "Protocol"
  }

  dimension: labels__request_id {
    type: string
    sql: ${TABLE}.labels.request_id ;;
    group_label: "Labels"
    group_item_label: "Request ID"
  }

  dimension: labels__source {
    type: string
    sql: ${TABLE}.labels.source ;;
    group_label: "Labels"
    group_item_label: "Source"
  }

  dimension: labels__type {
    type: string
    sql: ${TABLE}.labels.type ;;
    group_label: "Labels"
    group_item_label: "Type"
  }

  dimension: log_name {
    type: string
    sql: ${TABLE}.logName ;;
  }

  dimension_group: receive_timestamp {
    type: time
    description: "bq-datetime"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.receiveTimestamp ;;
  }

  dimension: resource__labels__project_id {
    type: string
    sql: ${TABLE}.resource.labels.project_id ;;
    group_label: "Resource Labels"
    group_item_label: "Project ID"
  }

  dimension: resource__type {
    type: string
    sql: ${TABLE}.resource.type ;;
    group_label: "Resource"
    group_item_label: "Type"
  }

  dimension: severity {
    type: string
    sql: ${TABLE}.severity ;;
  }

  dimension: text_payload {
    type: string
    sql: ${TABLE}.textPayload ;;
  }

  dimension_group: timestamp {
    type: time
    description: "bq-datetime"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.timestamp ;;
  }

  dimension: trace {
    type: string
    sql: ${TABLE}.trace ;;
  }

  measure: count {
    type: count
    drill_fields: [log_name]
  }
}
