def app
def nginx
def mariadb
def phpmyadmin
def app_prod ='alexandrupetrini/php:7.4-fpm-alpine-production'
def nginx_prod ='alexandrupetrini/nginx:1.18.0-alpine-production'
def mariadb_prod ='alexandrupetrini/mariadb:10.5-production'
def phpmyadmin_prod ='alexandrupetrini/phpmyadmin:5.0.2-apache-production'
def networkName = 'app-network'

node {

    stage('Clone repository') {
        git credentialsId: 'github-credentials', url: 'git@github.com:alexandrupetrini/laravel_app.git'
        checkout scm
    }

    // stage("build and deploy laravel_app") {
    stage('Build images'){
        stage('Build app image') {
            app = docker.build("${app_prod}", "--build-arg PHP_ENV=production ./Docker/app")
            app = docker.build("${app_prod}", "--build-arg PHP_ENV=production -f ./Docker/app/jenkins.Dockerfile ./Docker/app")
        }
        stage('Push app image') {
            docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                app.push()
            }
        }

        stage('Build nginx image') {
            nginx = docker.build("${nginx_prod}", "-f ./Docker/nginx/jenkins.Dockerfile ./Docker/nginx")
        }
        stage('Push nginx image') {
            docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                nginx.push()
            }
        }
    }

    stage('Setup Network') {
        try{
            sh "docker network create ${networkName}"
        }
        catch(all) {
            sh "echo 'Unable to create network'"
        }
    }

}

pipeline{
    agent none
    stages {
        stage('app') {
            agent {
                docker {
                    image "${app_prod}"
                    args  "--network ${networkName} --name app"
                }
            }
            steps {
                sh "composer install"
                sh "npm install && npm run prod"
                sh "cp .env.production .env"
                sh "php artisan key:generate"
            }
        }
        stage('nginx') {
            agent {
                docker {
                    image "${nginx_prod}"
                    args  "--network ${networkName} --name nginx -p 80:8181 -p 443:8143"
                }
            }
            steps {
                echo done
            }
        }
    }
}
