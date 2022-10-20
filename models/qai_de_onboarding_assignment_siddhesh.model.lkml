connection: "qai_de_onboarding_assignment_siddhesh"

# include all the views
include: "/views/**/*.view"

datagroup: qai_de_onboarding_assignment_siddhesh_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: qai_de_onboarding_assignment_siddhesh_default_datagroup

explore: session_level_data_of_dialogflow_cleaned_logs {}

explore: test_dialogflow_agent {}

explore: dialogflow_cleaned_logs {}
