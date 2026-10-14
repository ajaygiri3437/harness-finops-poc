resource "dynatrace_metric_events" "ec2_high_cpu" {
  enabled = true
  summary = "EC2 High CPU - POC Instance"

  event_template {
    title       = "EC2 High CPU - POC Instance"
    description = "CPU utilization exceeded 80% on the selected EC2 instance."
    event_type  = "CUSTOM_ALERT"
    davis_merge = false
  }

  model_properties {
    type               = "STATIC_THRESHOLD"
    alert_condition    = "ABOVE"
    threshold          = 80
    samples            = 5
    violating_samples  = 5
    dealerting_samples = 5
    alert_on_no_data   = false
  }

query_definition {
    type        = "METRIC_SELECTOR"
    aggregation = "AVG"
    metric_selector = <<-EOT
cloud.aws.ec2.CPUUtilization.By.InstanceId:filter(eq("InstanceId","i-045b06c863af2ad92"))
EOT
  }
}
