#!/bin/bash

if [ -f ".env" ]; then
    echo "A .env fájl már létezik"
else
    cp .env.example .env
fi

docker compose up -d
