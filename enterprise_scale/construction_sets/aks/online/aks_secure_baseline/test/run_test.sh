#!/bin/bash

TEST_FILE=$1

export CGO_ENABLED=0
go mod tidy

go test -v $TEST_FILE
