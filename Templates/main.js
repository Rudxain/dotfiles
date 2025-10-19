#!/usr/bin/env node
//"use strict"; // ESM default
import { argv, process } from "node:process";

/**
@param {readonly string[]} args
*/
const main = (...args) => {
	console.log("hello world");
};

process.exitCode = main(...argv.slice(1));
