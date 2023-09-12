view: demo1 {

  derived_table: {

    sql: select demo.id as id,
                DATE(demo.date_time) as dt
                from qp-qai-training-1-2021-05.siddhesh_bhere_qai_assignment3.demo
                where DATE(demo.date_time) between (DATE({% date_start date_filter %})) and (DATE_ADD(DATE({% date_start date_filter %}), INTERVAL 1 MONTH));;
  }

  filter: date_filter {
    description: "Use this date filter in combination with the timeframes dimension for dynamic date filtering for fetching start date"
    type: date
    suggest_explore: demo
    suggest_dimension: demo.created_at
  }


  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }
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
  }
