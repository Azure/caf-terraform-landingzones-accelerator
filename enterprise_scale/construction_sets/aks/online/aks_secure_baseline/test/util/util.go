package util

import (
	"fmt"
	"os"

	"github.com/spf13/viper"
)

func ReadTestConfig(configFile string, configuration interface{}) {
	viper.SetConfigName(configFile)
	viper.AddConfigPath(".")
	viper.SetConfigType("yml")
	if err := viper.ReadInConfig(); err != nil {
		fmt.Printf("Error reading config file, %s", err)
	}

	err := viper.Unmarshal(configuration)
	if err != nil {
		fmt.Printf("Unable to decode into struct, %v", err)
	}
}

func ResolveNameWithPrefix(rawName string) string {
	return fmt.Sprintf("%s-%s", os.Getenv("PREFIX"), rawName)
}
