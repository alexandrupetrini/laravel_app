// node {
//     def app

//     stage('Clone repository') {
//         /* Let's make sure we have the repository cloned to our workspace */

//         checkout scm
//     }

//     stage('Build image') {
//         /* This builds the actual image; synonymous to
//          * docker build on the command line */

//         app = docker.build("")
//     }

//     stage('Test image') {
//         /* Ideally, we would run a test framework against our image.
//          * For this example, we're using a Volkswagen-type approach ;-) */

//         app.inside {
//             sh 'echo "Tests passed"'
//         }
//     }

//     stage('Push image') {
//         /* Finally, we'll push the image with two tags:
//          * First, the incremental build number from Jenkins
//          * Second, the 'latest' tag.
//          * Pushing multiple tags is cheap, as all the layers are reused. */
//         docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
//             app.push("${env.BUILD_NUMBER}")
//             app.push("latest")
//         }
//     }
// }

// pipeline {
//     agent none

//     stages {
//         stage('Clone repository') {
//             /* Let's make sure we have the repository cloned to our workspace */

//             checkout scm
//         }
//         stage("build and deploy laravel_app) {
//             parallel {
//                 stage("app") {
//                     agent {
//                         label "windows"
//                     }
//                     stages {
//                         stage("build") {
//                             steps {
//                                 bat "run-build.bat"
//                             }
//                         }
//                         stage("deploy") {
//                             when {
//                                 branch "master"
//                             }
//                             steps {
//                                 bat "run-deploy.bat"
//                             }
//                         }
//                     }
//                 }

//                 stage("linux") {
//                     agent {
//                         label "linux"
//                     }
//                     stages {
//                         stage("build") {
//                             steps {
//                                 sh "./run-build.sh"
//                             }
//                         }
//                         stage("deploy") {
//                              when {
//                                  branch "master"
//                              }
//                              steps {
//                                 sh "./run-deploy.sh"
//                             }
//                         }
//                     }
//                 }
//             }
//         }
//     }
// }


node {
    agent none
    def app
    def app_prod='alexandrupetrini/php:7.4-fpm-alpine-production'
    def app_dev='alexandrupetrini/php:7.4-fpm-alpine-development'
    def php_image='php:7.4-fpm-alpine'

    stages {
        stage('Clone repository') {
          /* Let's make sure we have the repository cloned to our workspace */
          checkout scm
        }

        stage("build app prod"){
            agent {
                docker true
            }
            app = docker.build("${php_image}", "-t ${app_prod} --build-args PHP_ENV=production ./Docker/app")
        }
    }
}
