#!/bin/bash

# Creation de 10 users

for INDEX in {1..10}; do
	addgroup user${INDEX} --gid 1000${INDEX}
	adduser user${INDEX} -q --uid 1000${INDEX} --gid 1000${INDEX} --disabled-password
done;
