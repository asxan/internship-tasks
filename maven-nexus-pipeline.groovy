import java.util.regex.Pattern

def mail_datas(String toRecipient, String ccRecipient, String project_name)
{   
    def final_list = []
    def date = new Date()
    println("$date")
    final_list[0] = toRecipient
    final_list[1] = ccRecipient
    final_list[2] = "[${project_name}] [BASH Validation] [${date.format("yyyy-MM-dd HH:mm:ss")} UTC]"
    return final_list
}

def mail_notification(String toRecipient, String ccRecipient, String sSubject, String message)
{
    mail to: "${toRecipient}",
        cc: "${ccRecipient}",
        subject: "${sSubject}",
        mimeType: "text/html",
            body: """
            <head>
            <style type="text/css"> .simplyText{ color: "red"; font-size: 100%; } .bottomText{ font-size: 90%; font-style: "italic"} 
                    #form {
                        position: absolute;
                        width: 14px; 
                    }
            </style>
            </head>
            <body>
            <p>Dear developer,</p>
            <p>We have sent you a mail notification about build of your project.</p>
            <pre>
            </pre>
            <p>Result of build:</p>              
            <pre>
            </pre>
            <p>"""+ message +"""</p>
            <pre>
            </pre>
            <p>Best regards,</p>
            <p>Support command of your project</p>
            <p class="bottomText">This is an automatically generated email – please do not reply to it.</p>
            </body>
            """
}

String nodeName = "${NODE}"
node(nodeName) 
{   try
    {
        stage("Git clone")
        {   
            sh 'echo "Executing..." '
            dir("workdir")
            {   script
                {
                    git branch: 'main', credentialsId: 'jenkins_task_key', url: 'git@github.com:asxan/spring-petclinic.git'
                }
            }
        }
    }
    catch(Exception ex)
    {
        script{
            sh """
            rm -rf *
            rm -rf .git
            ls -la
            """
        }
    }  
    try
    {
        stage("Set Version")
        {   
            script
            {
                dir("workdir")
                {
                    def version = sh(script: '''cat pom.xml | grep -o "<version>.*</version>" | head -n 1 | sed -e 's/<version>\\(.*\\)<\\/version>/\\1/' ''', returnStdout: true).trim()
                    
                    if ("$REPOSITORY" == "releases"){
                        println ("$version")

                        sh "mvn versions:set -DnewVersion=${version}"
                    }
                    else if ("$REPOSITORY" == "snapshot"){
                        version = "$version-SNAPSHOT"
                        println ("$version")

                        sh "mvn versions:set -DnewVersion=${version}"
                    }
                }
            }
        }
        stage('Compile')
        {
            dir("workdir")
            {
                withCredentials([file(credentialsId: 'settings_xml', variable: 'settings')]) {
                    //sh 'echo "`cat $settings > /var/jenkins_home/.m2/wrapper/dists/apache-maven-3.6.3-bin/1iopthnavndlasol9gbrbg6bf2/apache-maven-3.6.3/conf/settings.xml`"'
                    sh 'echo "`cat $settings > /var/jenkins_home/.m2/settings.xml`"'
                }
                // sh """mvn -B -DskipTests -Dcheckstyle.skip clean package"""
                // echo "------------------------------------------"
                // sh "mvn dependency:tree"
                // sh "ls -la target/"
                // withCredentials([usernamePassword(credentialsId: 'nexus_admin_creds', passwordVariable: 'password', usernameVariable: 'username')]) {
                //     sh 'echo " `echo $password > ~/password.txt`"'
                // } 
            }
        }
        stage('Push to Nexus')
        {
            dir("workdir")
            {
                script
                {
                    sh "mvn clean deploy -Dmaven.test.skip=true -Dcheckstyle.skip"
                    sh "mvn dependency:tree"
                    // sh "echo "${maven.home}""
                }
            }
        }
        stage ('Sending status')
        {
            script
            {
                def date = new Date()
                println("$date")
                String toRecipient = "${EMAIL_ADDRESS}"
                String ccRecipient = ""
                String sSubject = "[${PROJECT_NAME}] [PROJECT BUILD] [${date.format("yyyy-MM-dd HH:mm:ss")} UTC]"
                message = "${EMAIL_MESSAGE}"
                println "${message}"
                sh ' echo "Mail to ${toRecipient} ${ccRecipient}" ' 
                mail_notification(toRecipient, ccRecipient, sSubject, message)
            } 
        }
        stage('Clear workdir')
        {
            script
            {
                sh """
                rm -rf *
                rm -rf .git
                ls -la
            """
            }
        }
    }
    catch(Exception ex)
    {
        script{
            def date = new Date()
            println("$date")
            String toRecipient = "${EMAIL_ADDRESS}"
            String ccRecipient = ""
            String sSubject = "[${PROJECT_NAME}] [PROJECT BUILD] [${date.format("yyyy-MM-dd HH:mm:ss")} UTC]"
            message = "The build was failed"
            println "${message}"
            sh ' echo "Mail to ${toRecipient} ${ccRecipient}" ' 
            mail_notification(toRecipient, ccRecipient, sSubject, message)
            sh """
            rm -rf *
            rm -rf .git
            ls -la
            """
        }
    }  
}