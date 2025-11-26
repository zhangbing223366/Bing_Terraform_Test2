terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.100"
    }
  }
}

provider "snowflake" {
  role      = "ACCOUNTADMIN"
  warehouse = "COMPUTE_WH"
}

resource "snowflake_database" "tf_demo_db" {
  name = "TF_DEMO_DB"
}

resource "snowflake_schema" "tf_demo_schema" {
  name     = "TF_DEMO_SCHEMA"
  database = snowflake_database.tf_demo_db.name
}

resource "snowflake_table" "students" {
  database = snowflake_database.tf_demo_db.name
  schema   = snowflake_schema.tf_demo_schema.name
  name     = "STUDENTS_TF"

  column {
    name = "ID"
    type = "NUMBER"
  }

  column {
    name = "NAME"
    type = "STRING"
  }

  column {
    name = "AGE"
    type = "NUMBER"
  }

  column {
    name = "GENDER"
    type = "STRING"
  }
}

output "students_table_fqn" {
  value = "${snowflake_database.tf_demo_db.name}.${snowflake_schema.tf_demo_schema.name}.${snowflake_table.students.name}"
}
