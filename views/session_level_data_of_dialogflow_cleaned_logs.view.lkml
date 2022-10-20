view: session_level_data_of_dialogflow_cleaned_logs {
  sql_table_name: `siddhesh_bhere_qai_assignment3.session_level_data_of_dialogflow_cleaned_logs`
    ;;

  dimension: average_of_sentiment_score {
    type: number
    sql: ${TABLE}.AverageOfSentimentScore ;;
  }

  dimension: conversation_duration_in_seconds {
    type: number
    sql: ${TABLE}.conversationDurationInSeconds ;;
  }

  dimension: entry_intent {
    type: string
    sql: ${TABLE}.entryIntent ;;
  }

  dimension: exit_intent {
    type: string
    sql: ${TABLE}.exitIntent ;;
  }

  dimension: language_code {
    type: string
    sql: ${TABLE}.languageCode ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
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
    drill_fields: []
  }
}
