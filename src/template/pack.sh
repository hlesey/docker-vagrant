#!/usr/bin/env bash

vagrant package --output output/docker-base.box 
vagrant box add output/docker-base.box --name hlesey/docker-base
