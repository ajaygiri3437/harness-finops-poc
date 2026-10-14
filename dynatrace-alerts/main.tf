resource "dynatrace_davis_anomaly_detectors" "ec2_high_cpu" {
  title       = "EC2 High CPU - POC Instance"
  description = "Alert when CPU utilization exceeds 80% on the selected EC2 instance."
  enabled     = true
  source      = "Harness OpenTofu POC"

  analyzer {
    name = "dt.statistics.ui.anomaly_detection.StaticThresholdAnomalyDetectionAnalyzer"

    input {
      analyzer_input_field {
        key   = "query"
        value = <<-DQL
          timeseries avg = avg(cloud.aws.ec2.CPUUtilization.By.InstanceId),
            by: {InstanceId, aws.account.id, aws.region}
          | filter InstanceId == "i-045b06c863af2ad92"
        DQL
      }

      analyzer_input_field {
        key   = "threshold"
        value = "80"
      }

      analyzer_input_field {
        key   = "alertCondition"
        value = "ABOVE"
      }

      analyzer_input_field {
        key   = "alertOnMissingData"
        value = "false"
      }

      analyzer_input_field {
        key   = "violatingSamples"
        value = "3"
      }

      analyzer_input_field {
        key   = "slidingWindow"
        value = "5"
      }

      analyzer_input_field {
        key   = "dealertingSamples"
        value = "5"
      }
    }
  }

  event_template {
    properties {
      property {
        key   = "event.type"
        value = "RESOURCE_CONTENTION_EVENT"
      }

      property {
        key   = "event.name"
        value = "EC2 High CPU - POC Instance"
      }

      property {
        key   = "event.description"
        value = "CPU utilization exceeded 80% for EC2 instance i-045b06c863af2ad92."
      }
    }
  }

  execution_settings {}
}
