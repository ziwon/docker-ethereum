/*
Author: Robert Lie (mobilefish.com)
More information about this file, see:
https://www.mobilefish.com/developer/blockchain/blockchain_quickguide_ethereum_tools.html

Purpose:
Compile and deploy a contract.
This script can only read 1 solidity file containing one or more contracts.
This script can not handle imports.

Prerequisites:
+ Nodejs: https://nodejs.org/en/download/
+ The following node modules are required:
  - solc: npm install -g solc
    https://www.npmjs.com/package/solc
  - fs: npm install -g fs
    https://www.npmjs.com/package/fs
  - web3: npm install -g web3
    https://www.npmjs.com/package/web3
  - bignumber.js: npm install -g bignumber.js
    https://www.npmjs.com/package/bignumber.js

  Note: Show all installed node modules:
  npm list -g --depth=0

+ Running Geth node:
  Tutorial setting up a Geth node:
  https://www.mobilefish.com/developer/blockchain/blockchain_quickguide_rinkeby_testnet.html

Usage:
- Place this script together with solidity files in the same folder.
- Run this script, type: node deploy_contract.js
*/

//----------------------------------------------------------------------------
// Node require
//----------------------------------------------------------------------------
var solc = require('solc');
var fs = require("fs");
var Web3 = require('web3');
var web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
var BigNumber = require('bignumber.js');


//----------------------------------------------------------------------------
// Change the settings below according to your situation
//----------------------------------------------------------------------------
let senderAddress = "0x2b417fe5d262443918358a92868c60922285eda1";
let password = "mysecret";

let fileName = "DemoCombined.sol";
let contractName = "Demo";

let deployContract = true;

// If estimated gas does not match the actual gas usage, add additionalGas
let additionalGas = 50000;

// Deploy a contract with ether attached (= transferValueWei)
// The transferValueWei is in wei
var transferValueWei = 20000000000;

// 1 Eth = 173 euro
let ethToFiatCurrency = 173;
let currencyUnit = "Euro";


// Edit the line: var contract = MyContract.new(5, "hello world"
// Change the constructor parameter values!

//----------------------------------------------------------------------------
// Below this line do not make changes unless you know what you are doing.
//----------------------------------------------------------------------------

// Unlock account.
web3.personal.unlockAccount(senderAddress, password);

//
let ethToFiatCurrencyBig = web3.toBigNumber(ethToFiatCurrency);
console.log("1 Ether: "+ethToFiatCurrencyBig+ " "+currencyUnit +" (roughly)");

// Show account balance
let balanceWei = web3.eth.getBalance(senderAddress);
let balanceEther = web3.fromWei(balanceWei, "ether");

let balanceEtherBig = web3.toBigNumber(balanceEther);
let balanceInFiatCurrencyBig = balanceEtherBig.times(ethToFiatCurrencyBig);
console.log("Account: "+senderAddress);
console.log("Account balance (Wei): "+balanceWei);
console.log("Account balance (Ether): "+balanceEther);
console.log("Account balance ("+currencyUnit+"): "+balanceInFiatCurrencyBig);

// Read the solidity file and store the content in source
// https://nodejs.org/api/fs.html
let source = fs.readFileSync(fileName, 'utf8');

// inputFilesContent is an assiociative array inputFilesContent['Filename.sol'] = FileContent
let inputFilesContent = {};
inputFilesContent[fileName] = source;

// https://github.com/ethereum/solc-js
// Setting 1 as second parameter activates the optimiser
let compiledContract = solc.compile({sources: inputFilesContent},1);

// https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify
// JSON.stringify
// replacer function = null
// space = 4: Number of spaces for an indent. For readability of the compiled_output.json.
console.log("Contract is compiled, see file compiled_output.json");
fs.writeFileSync("compiled_output.json", JSON.stringify(compiledContract,null,4));

// Extracts all data from the javascript object after contracts.fileName:contractName
let theContract = compiledContract.contracts[fileName+":"+contractName];
//console.log("theContract: "+JSON.stringify(theContract,null,4));

// Extracts all data from the javascript object after contracts.fileName:contractName.interface
// Store to content in file compiled_output.abi
let abi = theContract.interface;
fs.writeFileSync("compiled_output.abi",abi);
//console.log("abi: "+JSON.stringify(JSON.parse(abi),null,4));

// Extracts all data from the javascript object after contracts.fileName:contractName.bytecode
// and prepend with "0x". Bytecode should always start with 0x.
let bytecode = "0x"+theContract.bytecode;
//console.log("bytecode: "+bytecode);

// Convert transferValueWei in different units
let transferValueEther = web3.fromWei(transferValueWei, "ether");
let transferValueEtherBig = web3.toBigNumber(transferValueEther);
let transferValueInFiatCurrencyBig = transferValueEtherBig.times(ethToFiatCurrencyBig);
console.log("TransferValue (Wei): "+transferValueWei);
console.log("TransferValue (Ether): "+transferValueEther);
console.log("TransferValue ("+currencyUnit+"): "+transferValueInFiatCurrencyBig);

// Get the estimated gas required to deploy the code.
// Add additional gas if the gasLimit is too low.
let estimateGas = web3.eth.estimateGas({data: bytecode});
let estimateGasBig = web3.toBigNumber(estimateGas);
let additionalGasBig = web3.toBigNumber(additionalGas);
let totalEstimateGasBig = estimateGasBig.add(additionalGasBig);
console.log("Estimate gas: "+estimateGas);
console.log("User added additionalGas: "+additionalGas);
console.log("Total estimate gas: "+totalEstimateGasBig);

// Get the gasPrice. Default value set in the Geth node.
// The gas price is based per unit gas.
let gasPriceWei = web3.eth.gasPrice;
let gasPriceEther = web3.fromWei(gasPriceWei, "ether");
let gasPriceEtherBig = web3.toBigNumber(gasPriceEther);
let gasPriceInFiatCurrencyBig = gasPriceEtherBig.times(ethToFiatCurrencyBig);
console.log("GasPrice (Wei/gas unit): "+gasPriceWei);
console.log("GasPrice (Ether/gas unit): "+gasPriceEther.toString(10));
console.log("GasPrice ("+currencyUnit+"/gas unit): "+gasPriceInFiatCurrencyBig);

// Calculate the total price
// https://github.com/ethereum/wiki/blob/master/JavaScript-API.md
// http://mikemcl.github.io/bignumber.js/
let gasPriceWeiBig = web3.toBigNumber(gasPriceWei);
let priceWeiBig = totalEstimateGasBig.times(gasPriceWeiBig);
let priceEtherBig = web3.fromWei(priceWeiBig, "ether")
let priceInFiatCurrencyBig = priceEtherBig.times(ethToFiatCurrencyBig);
console.log("Estimated price = total estimate gas * gasPrice");
console.log("Estimated price (Wei): "+priceWeiBig);
console.log("Estimated price (Ether): "+priceEtherBig);
console.log("Estimated price ("+currencyUnit+"): "+priceInFiatCurrencyBig);

// Create a javascript contract object. This contract is going to be deployed.
var MyContract = web3.eth.contract(JSON.parse(abi));
//console.log("MyContract: "+JSON.stringify(MyContract,null,4));


// Deploy the contract into the blockchain
// If there is NO contructor
// MyContract.new({from:senderAddress, data:bytecode, gas:estimatedGas});
// If there is a constructor with 1 or more parameters
// MyContract.new(param1, param2, paramN, {from:senderAddress, data:bytecode, gas:totalEstimateGasBig});
if(deployContract) {
  var contract = MyContract.new(5, "hello world", {from:senderAddress, data:bytecode, gas:totalEstimateGasBig, value: transferValueWei});

  // Transaction has entered to geth memory pool
  console.log("Contract is being deployed, please wait...");
  console.log("TransactionHash: " + contract.transactionHash);

  waitBlock();
}

// http://stackoverflow.com/questions/951021/what-is-the-javascript-version-of-sleep
function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

// Wait for a miner to include the transaction in a block.
// Only when the transaction is included in a block the contract address in available.
async function waitBlock() {
  while (true) {
    let receipt = web3.eth.getTransactionReceipt(contract.transactionHash);
    if (receipt && receipt.contractAddress) {
      console.log("Contract is deployed at contract address: " + receipt.contractAddress);
      console.log("It might take 30-90 seconds for the block to propagate before it's visible in etherscan.io");
      break;
    }
    console.log("Waiting for a miner to include the transaction in a block. Current block: " + web3.eth.blockNumber);
    await sleep(4000);
  }
}
