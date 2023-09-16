connection: "qai_de_onboarding_assignment_siddhesh"

# include all the views
include: "/views/**/*.view"

datagroup: qai_de_onboarding_assignment_siddhesh_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: qai_de_onboarding_assignment_siddhesh_default_datagroup

explore: test {}

explore: demo {
  join: demo1 {
    type: inner
    sql_on: ${demo.id} = ${demo1.id} ;;
    relationship: many_to_one
  }
}

explore: session_level_data_of_dialogflow_cleaned_logs {}

explore: test_dialogflow_agent {

}

explore: dialogflow_cleaned_logs {
  access_filter: {
    field: dialogflow_cleaned_logs.platform
    user_attribute: platform_rls
  }
}

access_grant: sentiment_filter {
  user_attribute: platform_rls
  allowed_values: ["voice"]
}
