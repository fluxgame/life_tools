#!/bin/sh
export $(cat docker.env | xargs)
mix phx.server
