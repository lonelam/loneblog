#!/bin/bash

pnpm run build
scp -r ./public/* root@laizn.com:/www/