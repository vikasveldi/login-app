pipeline {
    agent any;
    stages {
        stage("code checkout") {
            steps {
                git url:"https://github.com/vikasveldi/login-app.git", branch:"main" 
            }
        }
        stage("code build") {
            steps {
                sh "docker build -t login-app:v1 ."
            }
        }
        stage("code test") {
            steps {
                echo "run tests using unit tests/integration tests"
            }
        }
        stage("docker push") {
            steps {
                withCredentials([usernamePassword(credentialsId:"dockerHubCreds", usernameVariable:"dockerHubUser", passwordVariable:"dockerHubPass")]) {
                   sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}"
                   sh "docker image tag login-app:v1 ${env.dockerHubUser}/login-app:v1"
                   sh "docker push ${env.dockerHubUser}/login-app:v1"
                }
            }
        }
        stage("code deploy") {
            steps {
                sh "docker container run -dt --name login-app -p 80:80 vikasveldi/login-app:v1"
            }
        }
    }
}
