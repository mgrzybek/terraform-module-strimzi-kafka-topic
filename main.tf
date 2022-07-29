resource "kubernetes_manifest" "kafka-topic" {
  manifest = {
    "apiVersion" = "kafka.strimzi.io/v1beta2"
    "kind"       = "KafkaTopic"
    "metadata" = {
      "labels" = {
        "strimzi.io/cluster" = var.cluster
      }
      "name"      = var.name
      "namespace" = var.namespace
    }
    "spec" = {
      "partitions" = var.partitions
      "replicas"   = var.replicas
    }
  }
}

resource "kubernetes_manifest" "topic-consumer" {
  depends_on = [kubernetes_manifest.kafka-topic]

  manifest = {
    "apiVersion" = "kafka.strimzi.io/v1beta2"
    "kind"       = "KafkaUser"
    "metadata" = {
      "labels" = {
        "strimzi.io/cluster" = var.cluster
      }
      "name"      = "${var.name}-consumer"
      "namespace" = var.namespace
    }
    "spec" = {
      "authentication" = {
        "type" = "plain"
      }
      "authorization" = {
        "acls" = [
          {
            "host"      = "*"
            "operation" = "Read"
            "resource" = {
              "name"        = "${var.name}"
              "patternType" = "literal"
              "type"        = "topic"
            }
          },
          {
            "host"      = "*"
            "operation" = "Describe"
            "resource" = {
              "name"        = "${var.name}"
              "patternType" = "literal"
              "type"        = "topic"
            }
          },
        ]
        "type" = "simple"
      }
    }
  }
}

resource "kubernetes_manifest" "topic-producer" {
  depends_on = [kubernetes_manifest.kafka-topic]

  manifest = {
    "apiVersion" = "kafka.strimzi.io/v1beta2"
    "kind"       = "KafkaUser"
    "metadata" = {
      "labels" = {
        "strimzi.io/cluster" = var.cluster
      }
      "name"      = "${var.name}-producer"
      "namespace" = var.namespace
    }
    "spec" = {
      "authentication" = {
        "type" = "plain"
      }
      "authorization" = {
        "acls" = [
          {
            "host"      = "*"
            "operation" = "Write"
            "resource" = {
              "name"        = "${var.name}"
              "patternType" = "literal"
              "type"        = "topic"
            }
          },
          {
            "host"      = "*"
            "operation" = "Describe"
            "resource" = {
              "name"        = "${var.name}"
              "patternType" = "literal"
              "type"        = "topic"
            }
          },
        ]
        "type" = "simple"
      }
    }
  }
}

