#!groovy

node {
    currentBuild.result = "SUCCESS"

    try {
        stage('Checkout'){
            checkout scm
        }

        stage('Build'){
            env.NODE_ENV = "build"
            print "Environment will be : ${env.NODE_ENV}"
                dir('./adminutil') {
                sh('
                    #!/bin/sh
                    # Build script
                    set -e
                    e () {
                        echo $( echo ${1} | jq ".${2}" | sed 's/\"//g')
                    }
                    m=$(./src/metadata.sh)

                    org=$(e "${m}" "org")
                    name=$(e "${m}" "name")
                    version=$(e "${m}" "version")

                    ./gradlew build --stacktrace
                    docker build -f ./Dockerfile -t ${org}/${name}:${version}-bronze .')
                                    }
        }

        stage('Publish'){
            echo 'Push to Repo'
            dir('./adminutil') {
                sh './src/metadata.sh > metadata.json'
                sh 'ARTIFACT_LABEL=bronze ./dockerPushToRepo.sh'
                sh 'cat metadata.json'
                archive includes: "metadata.json"
            }
       }
    }
    catch (err) {
        currentBuild.result = "FAILURE"
        throw err
    }

}
