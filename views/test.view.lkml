# The name of this view in Looker is "Test"
view: test {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `qp-qai-training-1-2021-05.siddhesh_bhere_qai_assignment3.test`
    ;;
  drill_fields: [id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Date Time" in Explore.

  dimension: date_time {
    type: string
    sql: ${TABLE}.Date_Time ;;
  }

  dimension_group: started_at {
    type: time
    timeframes: [
      raw,
      minute10,
      minute15,
      minute30,
      hour,
      hour_of_day,
      time,
      date,
      day_of_week,
      day_of_week_index,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.date_time  ;;
  }

  dimension: test_started_at_30_minute_bucket {
    type: string
    sql: concat(substring(${started_at_minute30},12,5)," - ",substring(TIMESTAMPADD(MINUTE, 30, ${started_at_minute30}),12,5)) ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
