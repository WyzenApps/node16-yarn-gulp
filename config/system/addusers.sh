#!/bin/bash

# Creation de 10 users

for INDEX in {1..9}; do
	addgroup user${INDEX} --gid 100${INDEX}
	adduser user${INDEX} -q --uid 100${INDEX} --gid 100${INDEX} --disabled-password
done;
