def merge(from, to) {
  sh('git checkout ' + to)
  sh('git merge ' + from + ' --ff-only')
}

def promote(Map parameters = [:]) {
  String from = parameters.from
  String to = parameters.to

  merge(from, to)

  sshagent(['control-repo-github']) {
    sh "git push origin " + to
  }

  //sh('git push origin ' + to)
}

node {
    git branch: 'library', credentialsId: 'gblbar1-control-repo-github-ssh', url: 'git@github.com:chlawren/control-repo.git'

    //stage 'Lint and unit tests'
    //withEnv(['PATH=/usr/local/bin:$PATH']) {
    //  sh 'bundle install'
    //  sh 'bundle exec rspec spec/'
    //}

    //Set the Jenkins credentials that hold our Puppet Enterprise RBAC token
    puppet.credentials 'deployment_user'

    stage 'Deploy to library'
    puppet.codeDeploy 'library'
    puppet.job 'library'

    stage 'Promote to non_production'
    input "Ready to deploy to Non-production?"
    promote from: 'library', to: 'non_production'
    
    stage 'Deploy to Non-production'
    puppet.codeDeploy 'non_production'
    puppet.job 'non_production'

    //stage 'Staging acceptance tests'
    // Run acceptance tests here to make sure no applications are broken

    stage 'Promote to production'
    promote from: 'non_production', to: 'production'
    puppet.codeDeploy 'production'

    stage 'Noop production run'
    puppet.job 'production', noop: true

    stage 'Deploy to production'
    input "Ready to deploy to production?"
    puppet.codeDeploy 'production'
    puppet.job 'production', concurrency: 40
}
