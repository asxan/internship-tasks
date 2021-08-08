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
        stage("Deploy petclinic")
        {
            dir("deploy_workdir")
            {
                script
                {
                    git branch: 'deploy-pet-playbook', credentialsId: 'jenkins_task_key', url: 'git@github.com:asxan/internship-tasks.git'
                }
                script
                {
                    ansiblePlaybook colorized: true, credentialsId: 'deploy_ssh', disableHostKeyChecking: true, installation: 'ansible1', inventory: 'hosts.txt', playbook: 'site.yml'
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
    }
    catch(Exception ex)
    {
        script{
            def date = new Date()
            println("$date")
            String toRecipient = "${EMAIL_ADDRESS}"
            String ccRecipient = ""
            String sSubject = "[${PROJECT_NAME}] [PROJECT BUILD] [${date.format("yyyy-MM-dd HH:mm:ss")} UTC]"
            message = "The deploy was failed"
            println "${message}"
            sh ' echo "Mail to ${toRecipient} ${ccRecipient}" ' 
            mail_notification(toRecipient, ccRecipient, sSubject, message)
        }
    }  
}