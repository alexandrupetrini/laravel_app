node {
    def app
    def nginx
    def nginx_prod='alexandrupetrini/nginx:1.18.0-alpine-production'
    def app_prod='alexandrupetrini/php:7.4-fpm-alpine-production'

    stage('Clone repository') {
        git credentialsId: 'github-credentials', url: 'git@github.com:alexandrupetrini/laravel_app.git'
        checkout scm
    }

    stage("build and deploy laravel_app") {
        stage('Build images'){
                    stage('Build app') {
                        stage('Build image') {
                            app = docker.build("${app_prod}", "--build-arg PHP_ENV=production ./Docker/app")
                            app = docker.build("${app_prod}", "--build-arg PHP_ENV=production -f ./Docker/app/jenkins.Dockerfile ./Docker/app")
                        }

                        stage('Push image') {
                            docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                                app.push()
                            }
                        }
                    }
                    stage('Build nginx'){
                        stage('Build image') {
                            nginx = docker.build("${nginx_prod}", "-f ./Docker/nginx/jenkins.Dockerfile ./Docker/nginx")
                        }
                        stage('Push image') {
                            docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                                nginx.push()
                            }
                        }
                    }
                }
            }
        }
    }
}
