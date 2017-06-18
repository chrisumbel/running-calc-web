
node("docker") {
    def selenium = docker.image('chrisumbel/selenium-ruby-firefox:latest');    
    def cf = docker.image('kramos/cloud-foundry-cli:latest');
    def node = docker.image('node:4.8.3');    

    stage("pull images") {
        selenium.pull();
        cf.pull();
        node.pull();
    }
    
    stage("pull source") {
        git 'https://github.com/chrisumbel/running_calc_web.git';
        
        node.inside() {
            sh 'npm install -g bower'
            sh 'bower install';
        }
    }

    selenium.inside() {
        stage("selenium tests") {
            sh '/virtual_firefox.sh&';
            sh 'DISPLAY=:19 rspec browser_tests.rb';
        }        
    }
    
    stage("publish") {
        cf.inside() {
            sh "cf login -a ${params.CF_API} -u ${params.CF_USERNAME} -p ${params.CF_PASSWORD} -o ${params.CF_ORG} -s ${params.CF_SPACE}";
            sh "cf push ${params.CF_APP} -b staticfile_buildpack -m 64m -i 1";
        }
    }    
}