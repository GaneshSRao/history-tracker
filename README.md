## Installing Quiz-Master using a Scratch Org

### Clone Quiz Master repository
git clone https://<span></span>github.com/GaneshSRao/history-tracker.git  <br/>
cd quiz-master

### Authorise a dev hub
sfdx force:auth:web:login -d -a DevHub

### Create a scratch org
sfdx force:org:create -s -f config/project-scratch-def.json -a history-tracker

### Push the app to scratch org
sfdx force:source:push

### Open the scratch org
sfdx force:org:open