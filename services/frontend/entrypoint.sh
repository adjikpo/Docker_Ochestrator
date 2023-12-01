#!/bin/bash

update-ca-certificates

if [[ ! -e frontend-app/node-modules ]]; then
    npm install
fi

cd frontend-app
npm run serve