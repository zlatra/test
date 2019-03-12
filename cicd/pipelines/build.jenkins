#!/usr/bin/env groovy

def label = "build-test-${UUID.randomUUID().toString()}"
def home = "/home/jenkins"
def workspace = "${home}/workspace/build-test"
def workdir = "${workspace}/src/github.com/test/"

podTemplate(label: label,
        containers: [
                containerTemplate(name: 'jnlp', image: 'jenkins/jnlp-slave:alpine'),
                containerTemplate(name: 'go', image: 'golang:1-alpine', command: 'cat', ttyEnabled: true),
        ]) {

    node(label) {
        dir(workdir) {
            stage('Init') {
                timeout(time: 3, unit: 'MINUTES') {
                    checkout scm
                }
                container('go') {
                    sh 'apk --no-cache --update add make git gcc libc-dev'
                }
            }

            stage('Build') {
                container('go') {
                    sh 'go version'
                }
            }
        }
    }
}
