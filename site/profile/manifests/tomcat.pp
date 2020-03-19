class profile::tomcat {

  class { 'java': }

  tomcat::install { '/opt/tomcat':
    source_url => 'https://www-us.apache.org/dist/tomcat/tomcat-9/v9.0.0.M22/bin/apache-tomcat-9.0.0.M22.tar.gz',
  }

  tomcat::instance { 'default':
    catalina_home => '/opt/tomcat',
  }

  tomcat::war { 'sample.war':
    catalina_base => '/opt/tomcat',
    war_source    => '/opt/tomcat/webapps/docs/appdev/sample/sample.war',
  }

}

