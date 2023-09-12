# The name of this view in Looker is "Demo"
view: demo {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `qp-qai-training-1-2021-05.siddhesh_bhere_qai_assignment3.demo`
    ;;
  drill_fields: [id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: created_at{
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
    sql: ${TABLE}.Date_Time ;;
  }

  dimension_group: incremented_time {
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
    sql:  TIMESTAMP_ADD(${started_at_raw} , INTERVAL 30 MINUTE);;
  }

  dimension: test_started_at_30_minute_bucket {
    type: string
    #sql: concat(substring(${started_at_minute30},12,5)," - ",substring (TIMESTAMP_ADD(TIMESTAMP (safe_cast(${started_at_minute30} as string)), INTERVAL 30 MINUTE) ,12,5)) ;;
    sql: concat(substring(${started_at_minute30},12,5)," - ",substring (${incremented_time_minute30},12,5)) ;;
  }



  dimension_group: started_at_30_minute_interval {
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
    sql: ${started_at_raw} ;;
    drill_fields: [started_at_minute30]
  }



  parameter: time_duration_picker {
    label: "Time Duration Picker"
    type: string
    allowed_value: {value:"Today"}
    allowed_value: {value:"Yesterday"}
    allowed_value: {value:"Last 7 days"}
    allowed_value: {value:"Last 30 days"}
    allowed_value: {value:"This Month to Date"}
    allowed_value: {value:"Last Month"}
    default_value: "Yesterday"
  }


  dimension_group: current {
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
    sql:CURRENT_TIMESTAMP() ;;
  }



  dimension: filter_this_month_to_date {
    description: "Dimension filters current Month's to date data"
    hidden: yes
    type: yesno
    sql: ${started_at_month} = ${current_month};;
  }




  dimension: filter_last_30_days {
    description: "Dimension filters last 30 days of data"
    hidden: yes
    type: yesno
    sql: ${started_at_date} between DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY) AND CURRENT_DATE();;
  }

  dimension: filter_last_7_days {
    description: "Dimension filters last 7 days of data"
    hidden: yes
    type: yesno
    sql: ${started_at_date} between DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY) AND CURRENT_DATE();;
  }

  dimension: filter_yesterday {
    description: "Dimension filters yesterday's data"
    hidden: yes
    type: yesno
    sql: ${started_at_date} = DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY);;
  }

  dimension: filter_today {
    description: "Dimension filters today's data"
    hidden: yes
    type: yesno
    sql: ${started_at_date} = CURRENT_DATE();;
  }

  dimension: dynamic_started_duration {
    label: "Started At (Duration)"
    description: "Dimension changes granularity as per value selected in 'Time Duration Picker' parameter"
    type: string
    label_from_parameter: time_duration_picker
    sql:
      CASE
      WHEN {% parameter time_duration_picker %} = 'This Month to Date' THEN CAST(${started_at_date} AS STRING)
      WHEN {% parameter time_duration_picker %} = 'Last 30 days' THEN CAST(${started_at_date} AS STRING)
      WHEN {% parameter time_duration_picker %} = 'Last 7 days' THEN CAST(${started_at_date} AS STRING)
      WHEN {% parameter time_duration_picker %} = 'Yesterday' THEN ${test_started_at_30_minute_bucket}
      WHEN {% parameter time_duration_picker %} = 'Today' THEN ${test_started_at_30_minute_bucket}
      END ;;
    drill_fields: [test_started_at_30_minute_bucket]

  }

  dimension: filter_time_duration {
    description: "Dimension to filter data as per value selected in 'Time Duration Picker' parameter"
    type: yesno
    label: "Filter Time Duration"
    sql:
      CASE
      WHEN {% parameter time_duration_picker %} = 'This Month to Date' THEN ${filter_this_month_to_date}
      WHEN {% parameter time_duration_picker %} = 'Last 30 days' THEN ${filter_last_30_days}
      WHEN {% parameter time_duration_picker %} = 'Last 7 days' THEN ${filter_last_7_days}
      WHEN {% parameter time_duration_picker %} = 'Yesterday' THEN ${filter_yesterday}
      WHEN {% parameter time_duration_picker %} = 'Today' THEN ${filter_today}
      END ;;
  }



  measure: count {
    type: count
    drill_fields: [id]
  }
}
