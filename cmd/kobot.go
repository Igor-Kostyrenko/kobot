/*
Copyright © 2023 NAME HERE <EMAIL ADDRESS>
*/
package cmd

import (
	"fmt"
	"log"
	"os"
	"time"

	"github.com/spf13/cobra"
	telebot "gopkg.in/telebot.v3"
)

var (
	// TeleToken bot
	TeleToken = os.Getenv("TELE_TOKEN")
)

// kobotCmd represents the kobot command
var kobotCmd = &cobra.Command{
	Use:     "kobot",
	Aliases: []string{"start"},
	Short:   "A brief description of your command",
	Long: `A longer description that spans multiple lines and likely contains examples
and usage of using your command. For example:

Cobra is a CLI library for Go that empowers applications.
This application is a tool to generate the needed files
to quickly create a Cobra application.`,
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("kobot %s started", appVersion)
		kobot, err := telebot.NewBot(telebot.Settings{
			URL:    "",
			Token:  TeleToken,
			Poller: &telebot.LongPoller{Timeout: 10 * time.Second},
		})

		if err != nil {
			log.Fatalf("Please chek TELE_TOKEN env variable. %s", err)
			return
		}

		kobot.Handle(telebot.OnText, func(m telebot.Context) error {

			log.Print(m.Message().Payload, m.Text())
			payload := m.Message().Payload

			switch payload {
			case "hello":
				err = m.Send(fmt.Sprintf("Hello I'm Kobot %s!", appVersion))

			}

			return err

		})

		kobot.Start()
	},
}

func init() {
	rootCmd.AddCommand(kobotCmd)

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// kobotCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// kobotCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}
