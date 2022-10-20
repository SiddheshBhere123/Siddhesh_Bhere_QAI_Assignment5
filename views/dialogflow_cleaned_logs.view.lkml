view: dialogflow_cleaned_logs {
  sql_table_name: `siddhesh_bhere_qai_assignment3.dialogflow_cleaned_logs`
    ;;

  dimension: intent_display_name {
    type: string
    sql: ${TABLE}.intentDisplayName ;;
  }

  dimension: intentis_fallback {
    type: yesno
    sql: ${TABLE}.intentisFallback ;;
  }

  dimension: language_code {
    type: string
    sql: ${TABLE}.languageCode ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: query_text {
    type: string
    sql: ${TABLE}.queryText ;;
  }

  dimension_group: receive_timestamp {
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
    sql: ${TABLE}.receiveTimestamp ;;
  }

  dimension: response_id {
    type: string
    sql: ${TABLE}.responseId ;;
  }

  dimension: sentiment_analysis_score {
    type: number
    sql: ${TABLE}.sentimentAnalysisScore ;;
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.sessionId ;;
  }

  dimension_group: timestamp {
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
    sql: ${TABLE}.timestamp ;;
  }

  measure: count {
    type: count
    drill_fields: [intent_display_name]
  }
}
