class graylog2::params {
  $server_name = "localhost"
  $external_hostname = "localhost"
  $update_local_syslog = true
  $graylog_dir = "/opt/graylog"
  $graylog_server_dir = "/opt/graylog_server"
  $graylog_server_url = "https://github.com/Graylog2/graylog2-server/releases/download/0.20.1/graylog2-server-0.20.1.tgz"
  $graylog_web_url = "https://github.com/Graylog2/graylog2-web-interface/releases/download/0.20.1/graylog2-web-interface-0.20.1.tgz"
  $mongodb_url = "http://fastdl.mongodb.org/linux/mongodb-linux-x86_64-2.0.2.tgz"
  $mongodb_dir = "/opt/mongodb"
  $mongodb_data_dir = "/opt/mongodb_data"
  $elasticsearch_dir = "/opt/elasticsearch"
  $elasticsearch_url = "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.1.1.tar.gz"
}
