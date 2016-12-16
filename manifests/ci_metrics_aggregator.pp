class profiles::ci_metrics_aggregator {
  # Pull the latest CI Metrics Aggregator Container
  docker::image{'msopenstack/ci_metrics_aggregator':
    ensure    => latest,
  }
  # Run the container at host startup
  docker::run { 'cim':
    image           => 'msopenstack/ci_metrics_aggregator',
    hostname        => 'cim',
    ports           => ['80:80'],
    restart_service => true,
    command         => '/bin/sh -c "while true; do /CIMetricsTool/bin/start-everything.sh; sleep 1; done"'
  }

}
