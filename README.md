# Instruction to create telegram bot
 
1.Create a new public repository   in GitHub
	
2.Add description to reposytory
	
3.Create file README.md , add description and  push "Commit new file"
	
4.Open your repository in github.dev (push "." on keyboard)
	
5.Create new codespace (cloud workspace your repository)
	  check version  #go version
	                 #zsh
  
6.Module initialization
	
	    #go mod init github.com/igor-kostyrenko/kobot

          This command add file go.mod
  
7.Install code generator cobra-cli
      
	    #go install github.com/spf13/cobra-cli@latest
	
8.Generate main.go (basic code file)
   
	    #cobra-cli init 
	
	(result  1. new file -  main.go, )
		       2. add strings to file  go.mod
		       3.  create folder "cmd" and file "root.go" in this folder
           "root.go" contains generated initial code.
	
9.Generate code of command "version"

	    #cobra-cli add version  

          (result  new file -  version.go in folder "cmd" )

10.Build code
    
      #go run main.go  help

11.Check command version

	 #go run main.go version
	
	 (result    -    version called)

12.Add main comand kobot

	#cobra-cli add kobot
	(result  new file -  kbot.go in folder "cmd" )
	
13.Adding a variable  "appVersion" 

	    In file version.go add string   -    var appVersion = "Version"
	
	   Change fmt.Print
     oldstring      fmt.Print("Version called")   
                newstring    fmt.Print(appVersion)

14.Prebuid application
	
	#go build -ldflags "-X="github.com/Igor-Kostyrenko/kobot/cmd.appVersion=v1.0.0
	
	result  - binary file kobot

15.Run kobot
       
	./kobot version

	
16.Import telebot packeges in file kobot.go
	
	 telebot "gopkg.in/telebot.v3"
	
17.Add variable TeleToken in file kobot.go

             var (
                    // TeleToken bot
                   TeleToken = os.Getenv("Tele_token")
            )

18.Add   "os'' to import in file  kobot.go

19.Add code function RUN
   
           fmt.Println("kobot %s started", appVersion)

20.Add block init kobot

            
          kobot, err := telebot.NewBot(telebot.Settings{
              URL:    "",
              Token:  TeleToken,
              Poller: &telebot.LongPoller{Timeout: 10 * time.Second},
          })

21.Add function error
      
     

           if err != nil {
               log.Fatalf("Please chek TELE_TOKEN env variable. %s", err)
            return
           }

22.Add code of Handle

      kobot.Handle(telebot.OnText, func(m telebot.Context) error {

   
23.Add start function
 
            kbot.Start()

24.Formatting code

           #gofmt -s -w ./

25.Install packeges

           #go get

26.Building app v1.0.1

           #go build -ldflags "-X="github.com/Igor-Kostyrenko/kobot/cmd.appVersion=v1.0.1

27.Add Aleases in kobot.go

  	Aliases: []string{"start"},
	
28.Create telegram bot from BotFather

29.Save bot Token from variable

	  read -s TELE_TOKEN
	
	  export TELE_TOKEN
	
30.Add code to Handle(answer to "hello")

	log.Print(m.Message().Payload, m.Text())
	            payload := m.Message().Payload
	            switch payload {
	            case "hello":
	                err = m.Send(fmt.Sprintf("Hello I'm Kobot %s!", appVersion))
	            }
	
31.Building app v1.0.1

     #go build -ldflags "-X="github.com/Igor-Kostyrenko/kobot/cmd.appVersion=v1.0.2

32.Start kobot

         #./kobot start

## Enjoy

Link to bot https://t.me/kostyrenko_bot

