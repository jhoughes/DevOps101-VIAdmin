### Add contents to SuperSecretData.md
`code SuperSecretData.md`

#### Insert this
`UserName`  
`Password`  
`AccessKeys`  
`...`  
`OhMy`  

## Demo - Local Git Only

`Get-ChildItem`

`code .`

`git init`

`git status`

`code SampleScript.ps1`

`git add SampleScript.ps1`

`git status`

`code .gitignore`

*Add this to the gitignore file & save*
`SuperSecretData.md`

`git commit -m 'First commit, add SampleScript'`

`git status`

----------------------------

## Demo - Working with Remote Repo

`git clone https://github.com/jhoughes/FromVMsToKubernetes`

`git log`

`code README`

*Add Text to file: *  
`#Adding a note to say hi from Canada 2021 VMUG Virtual UserCon`

`git status`

`git add .`

`git status`

`git commit -m'Hello from Canada 2021 VMUG Virtual Usercon'`

`git status`

`git push`

`git status`

----------------------------

## Demo - Checking Out Branches  

`git clone https://github.com/jhoughes/terraform-vmc-demo`

`cd terraform-vmc-demo`

`code .`

*Display all branches*  
`git branch -a`

`git checkout`

`git checkout create-sddc`

`git checkout add-nsxt-rules`

`git checkout create-vm`

